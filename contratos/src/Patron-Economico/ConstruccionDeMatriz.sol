// SPDX-License-Identifier: CC-BY-4.0
pragma solidity ^0.8.19;

contract ConstruccionDeMatriz {
    struct Item {
        string name;
        address owner;
        uint32 price;
    }

    Item[] public items;

    mapping(address => uint256) public ownerItemCount;

    function getItemIDsByOwner(address _owner) public view returns (uint[] memory ) {
        uint256[] memory result = new uint[](ownerItemCount[_owner]);
        uint256 counter = 0;

        for (uint256 i = 0; i < items.length; i++) {
            if (items[i].owner == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function createItem(string memory _name, uint32 _price) public {
        items.push(Item(_name, msg.sender, _price));
        ownerItemCount[msg.sender]++;
    }
}
