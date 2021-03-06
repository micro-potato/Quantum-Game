﻿package com.levels.lv4 {
	
	import com.BaseMovie;
	import com.mathematics.IonMath;
	import com.mc.BaseLv;
	import com.mc.BasePuzzle;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Lv4Main extends BaseMovie {
		
		//var mathHelper:IonMath;
		public const LevelEnd:String = "LevelEnd";
		public const Success:String = "Success";
		public const Fail:String = "Fail";
		private var _result:String;
		
		private var _puzzleMC:MovieClip;
		private var _puzzleHintMC:MovieClip;
		
		private var _currentLan:String;
		
		public function Lv4Main() {
			// constructor code
		}
		
		public function set Lan(value:String):void 
		{
			_currentLan = value;
		}
		
		public function get Result():String
		{
			return _result;
		}
		
		override protected function Init():void 
		{
			super.Init();
			var mc_openning:MC_Openning = new MC_Openning();
			_puzzleHintMC = new MC_PuzzleHint();
			this.addChild(mc_openning);
			mc_openning.addEventListener(MC_Openning.ChoiceMade, OnChoiceMade);
		}
		
		function OnChoiceMade(e:Event):void 
		{
			var mc_openning:MC_Openning = e.currentTarget as MC_Openning;
			if (mc_openning.IsSave)
			{
				//LoadPuzzle();
				LoadIntro();
			}
			else
			{
				var notSaveMC:MovieClip = new MC_NotSave();
				this.addChild(notSaveMC);
				notSaveMC.addEventListener(MouseEvent.CLICK, OnNotSaveClick);
			}
		}
		
		function LoadIntro():void 
		{
			this.addChild(_puzzleHintMC);
			_puzzleHintMC.addEventListener(MouseEvent.CLICK, OnHintClick);
		}
		
		function OnHintClick(e:Event):void 
		{
			_puzzleHintMC.removeEventListener(MouseEvent.CLICK, OnHintClick);
			this.removeChild(_puzzleHintMC);
			LoadPuzzle();
		}
		
		function LoadPuzzle():void 
		{
			_puzzleMC = new Lv4Puzzle();
			this.addChild(_puzzleMC);
			_puzzleMC.addEventListener(_puzzleMC.PuzzleEnd, OnPuzzleEnd);
		}
		
		function OnNotSaveClick(e:Event):void 
		{
			var notSaveMC:MovieClip = e.currentTarget as MovieClip;
			notSaveMC.removeEventListener(MouseEvent.CLICK, OnNotSaveClick);
			_result = this.Fail;
			this.dispatchEvent(new Event(this.LevelEnd));
		}
		
		function OnPuzzleEnd(e:Event):void 
		{
			OnPuzzleEndDeal();
		}
		
		protected function OnPuzzleEndDeal()
		{
			_puzzleMC.removeEventListener(_puzzleMC.PuzzleEnd, OnPuzzleEnd);
			this._result = _puzzleMC.Result;
			trace("get puzzle result:" + _result);
			this.dispatchEvent(new Event(this.LevelEnd));
		}
		
		override protected function removed_from_stage(e:Event):void 
		{
			//_puzzleMC.removeEventListener(_puzzleMC.PuzzleEnd, OnPuzzleEnd);
			super.removed_from_stage(e);
		}
	}
	
}
