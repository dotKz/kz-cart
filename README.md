# kz-cart

<a href="https://www.buymeacoffee.com/dotkz" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

**Cart management for QBR !**

- You can buy / sell / give cart
- Add stable in Config.lua (easy)
- Add cart to sell in Config.lua (easy)
- Each cart have an inventory
- Max Slots and Weight in Config.lua
- Cart can only be taken out at the place previously deposited
- Translation : Added the possibility of a translation (for the moment FR / EN (Google translate), you can easly add your).
- Menu : Main menu image can be changed in Config.lua


**For Inventory / Put in stable you can use QBR-Target or QTarget and use this event :**

- Inventory : ``` kz-cart:client:CartInventory ```
- Put In Stable : ``` kz-cart:client:PutInStable ```

*For QTarget (exemple):*
```bash
exports.qtarget:AddTargetModel({-1698498246, -2044900246, 1761016051}, {
	options = {
		{
			event = "qbr-cart:client:CartInventory",
			event = "kz-cart:client:CartInventory",
			icon = "fas fa-box-circle-check",
			label = "Coffre du chariot",
			num = 1
		},
		{
			event = "kz-cart:client:PutInStable",
			icon = "fas fa-box-circle-check",
			label = "Ranger le chariot",
			num = 2
		},
	},
	distance = 2
})
```

**Requirement :** 
- oxmysql
- qbr-core
- qbr-menu
- qbr-input
- qbr-inventory


