// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "./ERC721Interface.sol";

contract ERC721Contract {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed spender, uint256 indexed tokenId);
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    // Mapping token ID to owner address
    mapping(uint => address) internal _tokens;

    // Mapping owner address to token balances
    mapping(address => uint) internal _balances;

    // Mapping from token ID to approved address
    mapping(uint => address) internal _approvals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) public ownerApprovals;


    // Required ERC-721 functions
    function balanceOf(address owner) external view returns (uint256) {
        require(owner != address(0), "Owner address is zero address");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) external view returns (address){
        require(_tokens[tokenId] == address(0), "Token doesn't exist");
        return _tokens[tokenId];
    }

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require(_from == _tokens[_tokenId], "From address is not the owner of token");
        require(_to != address(0), "Cannot transfer to zero address");
        require(_from == msg.sender || msg.sender == _approvals[_tokenId], "You are not authorized to perform this action");

        _balances[_from]--;
        _balances[_to]++;
        _tokens[_tokenId] = _to;

        delete _approvals[_tokenId];
        emit Transfer(_from, _to, _tokenId);
    }

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT. When transfer is complete, this function
    ///  checks if `_to` is a smart contract (code size > 0). If so, it calls
    ///  `onERC721Received` on `_to` and throws if the return value is not
    ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    /// @param data Additional data with no specified format, sent in call to `_to`
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable {
//        transferFrom(from, to, _tokenId);
//
//        require(
//            to.code.length == 0 ||
//            IERC721Receiver(to).onERC721Received(msg.sender, from, _tokenId, data) ==
//            IERC721Receiver.onERC721Received.selector,
//            "This recipient is unsafe"
//        );
    }

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev This works identically to the other function with an extra data parameter,
    ///  except this function just sets data to "".
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
//        transferFrom(_from, _to, _tokenId);

//        require(
//            _to.code.length == 0 ||
//            IERC721Receiver(to).onERC721Received(msg.sender, _from, _tokenId, "") ==
//            IERC721Receiver.onERC721Received.selector, "This recipient is unsafe"
//        );
    }

    function approve(address _to, uint256 _tokenId) external {
        address owner = _tokens[_tokenId];
        require(msg.sender == owner || msg.sender == _approvals[_tokenId], "You are not authorized to perform this action");

        _approvals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param _operator Address to add to the set of authorized operators
    /// @param _approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address _operator, bool _approved) external {
        ownerApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT.
    /// @param _tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 _tokenId) external view returns (address) {
        require(_tokens[_tokenId] == address(0), "Token doesn't exist");
        return _approvals[_tokenId];
    }

    /// @notice Query if an address is an authorized operator for another address
    /// @param _owner The address that owns the NFTs
    /// @param _operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
        return ownerApprovals[_owner][_operator];
    }


    // Optional ERC-721 Meta Data Functions
    function name() external pure returns (string memory) {
        return "ERC-721";
    }

    function symbol() external pure returns (string memory) {
        return "ERC-721";
    }

    /// @notice A distinct Uniform Resource Identifier (URI) for a given asset.
    /// @dev Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
    ///  3986. The URI may point to a JSON file that conforms to the "ERC721
    ///  Metadata JSON Schema".
    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        require(_tokens[_tokenId] == address(0), "Token doesn't exist");

        return "https://nadabs-nfts.com/assets/83728782732";
    }
}
