package com.chaos.ui.classInterface;



/**
 *
 * @author Erick Feiling
 */


import com.chaos.data.DataProvider;
import openfl.display.BitmapData;

import com.chaos.ui.data.ItemPaneObjectData;

interface IItemPane extends IScrollPane
{
    
    /**
	 * Set the width of the item block size
	 */

    
    var itemWidth(get, set) : Int;    
    
    /**
	 * Set the height of the item block size
	 */

    
    var itemHeight(get, set) : Int;    
    
    /**
	 * Show or hide the label on button
	 */

    
    var showLabel(get, set) : Bool;    
    
    /**
	 * The item normal state color
	 */
    
    
    var itemNormalColor(get, set) : Int;    
    
    /**
	 * The item over state color
	 */
    
    
    var itemOverColor(get, set) : Int;    
    
    /**
	 * The item selected state color
	 */


    var itemSelectedColor(get, set) : Int;    
    
    /**
	 * The item disable state color
	 */

    
    var itemDisableColor(get, set) : Int;    
    
    /**
	 * The user can select more than one item on the item pane
	 */

    
    var allowMultipleSelection(get, set) : Bool;    
    
    /**
	 * Set the X location of the item
	 */

    var itemLocX(get, set) : Int;    
    
    /**
	 * Set the Y location of the item
	 */
    
    var itemLocY(get, set) : Int;    
    
    /**
	 * Replace the current data provider and rebuild the item pane
	 */

    var dataProvider(get, set) : DataProvider<ItemPaneObjectData>;

    
    /**
	 *
	 * The nomral state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */

    function setNormalItem(value : BitmapData) : Void;
    
    /**
	 *
	 * The over state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    function setOverItem(value : BitmapData) : Void;
    
    /**
	 *
	 * The down state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    function setSelectedItem(value : BitmapData) : Void;
    
    /**
	 * The disable state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    function setDisableItem(value : BitmapData) : Void;
    
    
    /**
	 * Returns the item at the selected index.
	 *
	 * @return The item at the selected index.
	 *
	 */
    
    function getSelected() : ItemPaneObjectData;
    
    /**
	 * A list of selected items
	 * @return An array with selected list items
	 */
    
    function getSelectedList() : Array<ItemPaneObjectData>;
    
    /**
	 * Return the index number of the item that was selected
	 */
    
    function selectIndex() : Int;
    
    /**
	 * Returns the listed item in the list
	 */
    
    function selectText() : String;
}

