// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DiscountRegistry
 * @notice Central on-chain registry for YieldLoop protocol-fee discounts
 * @dev See Appendix B — NFT Program
 *
 * Rules:
 * - Discounts apply ONLY to protocol fees
 * - Determined on-chain at settlement time
 * - Governor discount overrides Supporter discount
 * - Configurable prospectively by admin (no retroactive changes)
 */

import "@openzeppelin/contracts/access/AccessControl.sol";

interface IERC721Balance {
    function balanceOf(address owner) external view returns (uint256);
}

contract DiscountRegistry is AccessControl {
    bytes32 public constant CONFIG_ROLE = keccak256("CONFIG_ROLE");

    // Discount values in basis points (bps)
    // Example: 500 = 5%, 1000 = 10%
    uint256 public supporterDiscountBps;
    uint256 public governorDiscountBps;

    // NFT contract references
    IERC721Balance public supporterNFT;
    IERC721Balance public governorNFT;

    event DiscountsUpdated(uint256 supporterBps, uint256 governorBps);
    event NFTAddressesUpdated(address supporterNFT, address governorNFT);

    constructor(
        address admin,
        address supporterNFTAddress,
        address governorNFTAddress,
        uint256 initialSupporterDiscountBps,
        uint256 initialGovernorDiscountBps
    ) {
        require(admin != address(0), "admin zero");
        require(supporterNFTAddress != address(0), "supporter nft zero");
        require(governorNFTAddress != address(0), "governor nft zero");

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(CONFIG_ROLE, admin);

        supporterNFT = IERC721Balance(supporterNFTAddress);
        governorNFT = IERC721Balance(governorNFTAddress);

        supporterDiscountBps = initialSupporterDiscountBps;
        governorDiscountBps = initialGovernorDiscountBps;
    }

    /*//////////////////////////////////////////////////////////////
                        DISCOUNT LOOKUP
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Returns the applicable protocol-fee discount in basis points
     * @dev Governor discount overrides Supporter discount
     */
    function getDiscountBps(address user) external view returns (uint256) {
        if (governorNFT.balanceOf(user) > 0) {
            return governorDiscountBps;
        }
        if (supporterNFT.balanceOf(user) > 0) {
            return supporterDiscountBps;
        }
        return 0;
    }

    /*//////////////////////////////////////////////////////////////
                          ADMIN CONFIG
    //////////////////////////////////////////////////////////////*/

    function setDiscounts(
        uint256 newSupporterDiscountBps,
        uint256 newGovernorDiscountBps
    )
        external
        onlyRole(CONFIG_ROLE)
    {
        require(newGovernorDiscountBps >= newSupporterDiscountBps, "governor < supporter");

        supporterDiscountBps = newSupporterDiscountBps;
        governorDiscountBps = newGovernorDiscountBps;

        emit DiscountsUpdated(newSupporterDiscountBps, newGovernorDiscountBps);
    }

    function setNFTAddresses(
        address newSupporterNFT,
        address newGovernorNFT
    )
        external
        onlyRole(CONFIG_ROLE)
    {
        require(newSupporterNFT != address(0), "supporter zero");
        require(newGovernorNFT != address(0), "governor zero");

        supporterNFT = IERC721Balance(newSupporterNFT);
        governorNFT = IERC721Balance(newGovernorNFT);

        emit NFTAddressesUpdated(newSupporterNFT, newGovernorNFT);
    }

    /*//////////////////////////////////////////////////////////////
                        INTERFACE SUPPORT
    //////////////////////////////////////////////////////////////*/

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
