// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title YieldLoopGovernorNFT
 * @notice Restricted advisory-role NFT for YieldLoop Governors
 * @dev See Appendix B — NFT Program and Appendix H — Governance & Advisory
 *
 * Key properties:
 * - Team-only mint (bestowed)
 * - One per wallet
 * - Non-transferable by default
 * - Transfer allowed only with explicit admin authorization
 * - Revocable/burnable by admin
 * - Immutable deployment (no proxy)
 */

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract YieldLoopGovernorNFT is ERC721, AccessControl, Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant URI_ROLE    = keccak256("URI_ROLE");

    uint256 private _tokenIdCounter;
    string private _baseTokenURI;

    // Enforce one Governor per wallet
    mapping(address => bool) public hasGovernor;

    // One-time transfer authorization
    mapping(uint256 => address) public authorizedRecipient;

    event GovernorMinted(address indexed to, uint256 indexed tokenId, string reason);
    event GovernorRevoked(uint256 indexed tokenId, address indexed previousOwner);
    event TransferAuthorized(uint256 indexed tokenId, address indexed approvedRecipient);
    event BaseURIUpdated(string newBaseURI);

    constructor(
        address admin,
        string memory initialBaseURI
    ) ERC721("YieldLoop Governor", "YLG") {
        require(admin != address(0), "admin zero");

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
        _grantRole(PAUSER_ROLE, admin);
        _grantRole(URI_ROLE, admin);

        _baseTokenURI = initialBaseURI;
    }

    /*//////////////////////////////////////////////////////////////
                              MINTING
    //////////////////////////////////////////////////////////////*/

    function mintAdmin(
        address to,
        string calldata reason
    )
        external
        onlyRole(MINTER_ROLE)
        whenNotPaused
    {
        require(to != address(0), "to zero");
        require(!hasGovernor[to], "already governor");

        uint256 tokenId = ++_tokenIdCounter;
        hasGovernor[to] = true;

        _safeMint(to, tokenId);
        emit GovernorMinted(to, tokenId, reason);
    }

    /*//////////////////////////////////////////////////////////////
                         TRANSFER AUTHORIZATION
    //////////////////////////////////////////////////////////////*/

    function authorizeTransfer(
        uint256 tokenId,
        address approvedRecipient
    )
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        require(_exists(tokenId), "token DNE");
        require(approvedRecipient != address(0), "recipient zero");

        authorizedRecipient[tokenId] = approvedRecipient;
        emit TransferAuthorized(tokenId, approvedRecipient);
    }

    /*//////////////////////////////////////////////////////////////
                              REVOCATION
    //////////////////////////////////////////////////////////////*/

    function revoke(uint256 tokenId)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        address owner = ownerOf(tokenId);

        hasGovernor[owner] = false;
        delete authorizedRecipient[tokenId];

        _burn(tokenId);
        emit GovernorRevoked(tokenId, owner);
    }

    /*//////////////////////////////////////////////////////////////
                        METADATA / ADMIN
    //////////////////////////////////////////////////////////////*/

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
                       TRANSFER RESTRICTIONS
    //////////////////////////////////////////////////////////////*/

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    )
        internal
        override
        whenNotPaused
    {
        // Allow mint
        if (from == address(0)) {
            super._beforeTokenTransfer(from, to, tokenId, batchSize);
            return;
        }

        // Allow burn
        if (to == address(0)) {
            super._beforeTokenTransfer(from, to, tokenId, batchSize);
            return;
        }

        // Otherwise require explicit authorization
        require(authorizedRecipient[tokenId] == to, "transfer not authorized");

        // Update one-per-wallet tracking
        hasGovernor[from] = false;
        hasGovernor[to] = true;

        // Clear authorization after use
        delete authorizedRecipient[tokenId];

        super._beforeTokenTransfer(from, to, tokenId, batchSize);
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
