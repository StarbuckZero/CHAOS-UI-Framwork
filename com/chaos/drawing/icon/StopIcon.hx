package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;


//import com.chaos.drawing.icon.interface.IBasicIcon;
//import com.chaos.ui.interface.IBaseUI;

/**
 * Stop icon used for media players
 *
 * @author Erick Feiling
 */

class StopIcon extends BaseIcon implements IBasicIcon implements IBaseUI
{
    
    /**
	 * @inheritDoc
	 */
    
    public function new(iconWidth : Float = -1, iconHeight : Float = -1)
    {
        super(iconWidth, iconHeight);
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Create Icon
        _iconArea.graphics.clear();
        
        if (border) 
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
		
		(showImage && null != _image) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
        
        _iconArea.graphics.drawRect(0, 0, width, height);
        _iconArea.graphics.endFill();
    }
}

