// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721, ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

interface IERC165 {
    function supportsInterface(bytes4 interfaceID)
        external
        view
        returns (bool);
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(address from, address to, uint256 tokenId)
        external;
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
    function transferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId)
        external
        view
        returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator)
        external
        view
        returns (bool);
}

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract BeatTicket is ERC721("BeatTicket", "BTTK"), Ownable(0xc8F814566E2267D15C52ec20e6d2c291d153cCb0), ERC721Enumerable() {
    mapping(uint256 => TokenMetadata) public tokenMetadata;
    uint256 private _tokenIds;
    string private _tokenURI;
    struct TokenMetadata {
        uint256 eventID;
        string eventName;
        string eventDate;
        string ticketArea;
        string ticketType;
    }

    function mint(uint256 id, address to, string memory eventName, string memory eventDate, string memory ticketArea, string memory ticketType, string memory imageURI) external returns (uint256) {
        uint256 newItemId = _tokenIds++;
        _mint(to, newItemId);

    // Llenar el struct con los datos
        tokenMetadata[newItemId] = TokenMetadata({
        eventID: id,
        eventName: eventName,
        eventDate: eventDate,
        ticketArea: ticketArea,
        ticketType: ticketType
        });

       _tokenURI = imageURI;

        return newItemId;
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
      _safeMint(to, tokenId);
    }
    
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
      return super.supportsInterface(interfaceId);
    }
    
    function _update(
      address to,
      uint256 tokenId,
      address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
      return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
      super._increaseBalance(account, value);
    }
}
