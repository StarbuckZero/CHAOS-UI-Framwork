package com.chaos.drawing;

import com.chaos.utils.Debug;
import cpp.abi.Abi;
import openfl.display.Shape;
import haxe.macro.Type.Ref;
import openfl.display.BitmapData;
import haxe.Json;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;

import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Rectangle;
import openfl.utils.Assets;

/**
 * A 2D Layer filled with bitmap images based on data files
 *
 * @author Erick Feiling
 */



class TileLayer extends BaseUI implements IBaseUI
{

    private var _tileData:Dynamic;
    private var _tileMapData:Dynamic;

    private var _tileWidth:Int = 0;
    private var _tileHeight:Int = 0;
    private var _tileCount:Int = 0;

    private var _mapWidth:Int = -1;
    private var _mapHeight:Int = -1;

    private var _row:Int = 0;
    private var _column:Int = 0;

    private var _index:Int = 0;
    private var _colIndex:Int = 0;
    
    private var _tileBufferAmount:Int = 1;

    private var _tiles:Array<Dynamic>;
    private var _layers:Array<Dynamic>;
    private var _layerLength:Int = 0;

    /* Adjust the offset of the id number. This is for when items get exported in the Tiled Program.*/
    private var _idOffset:Int = -1;

    private var _content:Shape;

    private var _assetPrefix:String = "assets/";


    public function new(data:Dynamic = null)
    {
        super(data);
    }

    override function initialize() {
        super.initialize();

        _content = new Shape();
        addChild(_content);
    }

    override function setComponentData(data:Dynamic) {

        super.setComponentData(data);

        if(Reflect.hasField(data,"index"))
            _index = Reflect.field(data,"index");

        if(Reflect.hasField(data,"tileBufferAmount"))
            _tileBufferAmount = Reflect.field(data,"tileBufferAmount");        

        // Load files based off Asset Libray
        if(Reflect.hasField(data,"tileFile") && Reflect.hasField(data,"tileMap"))
            loadTitleAssetLibrary(Reflect.field(data,"tileFile"), Reflect.field(data,"tileMap"));

    }

    public function left( redraw:Bool = true ) {

        if(_index > (_mapHeight * _colIndex))
            _index--;

        if(redraw)
            draw();
    }

    public function right( redraw:Bool = true ) {

        
        if(_index < (_mapWidth * (_colIndex + 1)) - _row)
            _index++;

        if(redraw)
            draw();
    }

    public function up( redraw:Bool = true ) {

        if(_index >= _mapHeight) {
            _colIndex--;
            _index -= _mapHeight;
        }
        
        if(redraw)
            draw();
    }

    public function down( redraw:Bool = true ) { 

        
        if(_index < (_layerLength - _mapHeight)) {
            _colIndex++;
            _index += _mapHeight;
        }
            

        if(redraw)
            draw();        
    }

    public function loadTilesFromFile( value:String ):Void {

    }

    public function loadTitleAssetLibrary( tileAsset:String, tileMap:String ):Void {

        if(Assets.exists(tileAsset) && Assets.exists(tileMap))
            setupTileMap( Json.parse(Assets.getText(tileAsset)), Json.parse(Assets.getText(tileMap)) );
    }

    private function setupTileMap(tileDataObj:Dynamic, tileMapDataObj:Dynamic) {

        
        // Tile
        if(Reflect.hasField(tileDataObj,"tilewidth"))
            _tileWidth = Reflect.field(tileDataObj,"tilewidth"); 

        if(Reflect.hasField(tileDataObj,"tileheight"))
            _tileHeight = Reflect.field(tileDataObj,"tileheight");

        if(Reflect.hasField(tileDataObj,"tilecount"))
            _tileCount = Reflect.field(tileDataObj,"tilecount");

        if(Reflect.hasField(tileDataObj,"tiles"))
            _tiles = Reflect.field(tileDataObj,"tiles");


        // Map 
        if(Reflect.hasField(tileMapDataObj,"width"))
            _mapWidth = Reflect.field(tileMapDataObj,"width");

        if(Reflect.hasField(tileMapDataObj,"height"))
            _mapHeight = Reflect.field(tileMapDataObj,"height");
        
        // Layers
        if(Reflect.hasField(tileMapDataObj,"layers"))
            _layers = Reflect.field(tileMapDataObj,"layers");
        

        if(_mapWidth < 0 || _mapHeight < 0)
            Debug.print("[TileLayer::setupTileMap] The tileWidth and tileHeight must be set in order to draw anything");

        _tileData = tileDataObj;
        _tileMapData = tileMapDataObj;

    }

    override function draw() {
        super.draw();

        if(_mapWidth < 0 || _mapHeight < 0)
            return;

        _content.graphics.clear();

        var tileIndex:Int = _index;
        var layerCount:Int = 0;

        // Start drawing layer
        for(i in 0 ... _layers.length)
        {
            var layer:Dynamic = _layers[i];
            var layerMap:Array<Int> = Reflect.field(layer,"data");

            _row = Std.int(_width / _tileWidth) + _tileBufferAmount;
            _column = Std.int(_height / _tileHeight) + _tileBufferAmount;

            var rowCount:Int = 0;
            var colCount:Int = 0;

            if(layerCount <= 0)
                layerCount = layerMap.length;
            
            while(rowCount < _row && colCount < _column) {
                
                var image:BitmapData = getTile(layerMap[tileIndex + rowCount]);

                if(image != null)
                {
                    _content.graphics.beginBitmapFill(image);
                    _content.graphics.drawRect(rowCount * _tileWidth, colCount * _tileHeight, image.width, image.height);
                    _content.graphics.endFill();         
                }
                
                rowCount++;

                if(rowCount == _row)
                {
                    rowCount = 0;
                    tileIndex = tileIndex + _mapWidth;

                    colCount++;
                }
            }

        } 

        _layerLength = layerCount;

        trace("index: " + _index + " out of " + _layerLength + " column index: " + _colIndex);

    }
    

    private function getTile( id:Int ):BitmapData
    {

        // filter down tiles to return just one
        var tile:Array<Dynamic> = _tiles.filter(function(tileData:Dynamic) {return Reflect.field(tileData,"id") == (id + _idOffset);});

        // If found then grab that image
        if(tile.length > 0)
            return Assets.getBitmapData( _assetPrefix + Reflect.field(tile[0],"image"));

        return null;

    }

}