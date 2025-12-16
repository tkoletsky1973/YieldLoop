// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title YieldLoopSupporterNFT
 * @notice Public utility NFT for YieldLoop supporters
 * @dev See Appendix B — NFT Program
 *
 * - Public mint (unlimited)
 * - Admin mint for promotions/partnerships
 * - Transferable (standard ERC-721)
 * - Mint proceeds routed to treasury multisig
 * - No refunds
 * - Immutable deployment (no proxy)
 */

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract YieldLoopSupporterNFT is ERC721, AccessControl, Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant URI_ROLE    = keccak256("URI_ROLE");

    uint256 public mintPriceWei;
    address public treasury;

    uint256 private _tokenIdCounter;
    string private _baseTokenURI;

    event SupporterMinted(address indexed to, uint256 indexed tokenId);
    event SupporterAdminMinted(address indexed to, uint256 indexed tokenId);
    event MintPriceUpdated(uint256 newPriceWei);
    event TreasuryUpdated(address indexed newTreasury);
    event BaseURIUpdated(string newBaseURI);

    constructor(
        address admin,
        address treasuryMultisig,
        uint256 initialMintPriceWei,
        string memory initialBaseURI
    ) ERC721("YieldLoop Supporter", "YLS") {
        require(admin != address(0), "admin zero");
        require(treasuryMultisig != address(0), "treasury zero");

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
        _grantRole(PAUSER_ROLE, admin);
        _grantRole(URI_ROLE, admin);

        treasury = treasuryMultisig;
        mintPriceWei = initialMintPriceWei;
        _baseTokenURI = initialBaseURI;
    }

    /*//////////////////////////////////////////////////////////////
                              MINTING
    //////////////////////////////////////////////////////////////*/

    function mintPublic(uint256 qty) external payable whenNotPaused {
        require(qty > 0, "qty zero");
        require(msg.value == mintPriceWei * qty, "incorrect value");

        for (uint256 i = 0; i < qty; i++) {
            _mintOne(msg.sender);
        }

        _forwardFunds();
    }

    function mintAdmin(address to, uint256 qty)
        external
        onlyRole(MINTER_ROLE)
        whenNotPaused
    {
        require(qty > 0, "qty zero");
        require(to != address(0), "to zero");

        for (uint256 i = 0; i < qty; i++) {
            _mintOne(to);
        }
    }

    function _mintOne(address to) internal {
        uint256 tokenId = ++_tokenIdCounter;
        _safeMint(to, tokenId);
        emit SupporterMinted(to, tokenId);
    }

    /*//////////////////////////////////////////////////////////////
                              ADMIN
    //////////////////////////////////////////////////////////////*/

    function setMintPrice(uint256 newPriceWei)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        mintPriceWei = newPriceWei;
        emit MintPriceUpdated(newPriceWei);
    }

    function setTreasury(address newTreasury)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        require(newTreasury != address(0), "treasury zero");
        treasury = newTreasury;
        emit TreasuryUpdated(newTreasury);
    }

    function setBaseURI(string calldata newBaseURI)
        external
        onlyRole(URI_ROLE)
    {
        _baseTokenURI = newBaseURI;
        emit BaseURIUpdated(newBaseURI);
    }

    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /*//////////////////////////////////////////////////////////////
                              INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _forwardFunds() internal {
        (bool ok, ) = treasury.call{value: address(this).balance}("");
        require(ok, "treasury transfer failed");
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    /*//////////////////////////////////////////////////////////////
                          INTERFACE SUPPORT
    //////////////////////////////////////////////////////////////*/

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
