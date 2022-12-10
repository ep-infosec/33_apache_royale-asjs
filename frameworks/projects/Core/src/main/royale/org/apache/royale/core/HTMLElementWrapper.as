////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.royale.core
{
	import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.utils.removeBeadFromBeads;

    COMPILE::SWF
    {
        import flash.display.Sprite;
        import org.apache.royale.events.Event;
    }
        
    COMPILE::JS
    {
        import org.apache.royale.events.Event;        
        import org.apache.royale.events.BrowserEvent;
        import org.apache.royale.events.IBrowserEvent;
        import org.apache.royale.events.ElementEvents;
        import org.apache.royale.events.EventDispatcher;
        import goog.events;
        import goog.events.BrowserEvent;
        import goog.events.EventTarget;
        import goog.DEBUG;
        import org.apache.royale.events.utils.EventUtils;
        import org.apache.royale.utils.sendStrandEvent;
        import org.apache.royale.utils.loadBeadFromValuesManager;
        import org.apache.royale.debugging.assert;
    }
    import org.apache.royale.utils.loadBeadFromValuesManager;

    COMPILE::SWF
    public class HTMLElementWrapper extends Sprite implements IStrand, IEventDispatcher
    {
        
        private var _beads:Vector.<IBead>;
    
        /**
         * @param bead The new bead.
         */
        public function addBead(bead:IBead):void
        {
            if (!_beads)
            {
                _beads = new Vector.<IBead>();
            }
            _beads.push(bead);
        
            if (bead is IBeadModel)
            {
                _model = bead as IBeadModel;
            }
        
            bead.strand = this;
        }
    
        /**
         *  @copy org.apache.royale.core.IStrand#getBeadByType()
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        public function getBeadByType(classOrInterface:Class):IBead
        {
            for each (var bead:IBead in _beads)
            {
                if (bead is classOrInterface)
                    return bead;
            }
            return null;
        }
    
    
        /**
         *  @copy org.apache.royale.core.IStrand#removeBead()
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        public function removeBead(value:IBead):IBead
        {
            /*var n:int = _beads.length;
            for (var i:int = 0; i < n; i++)
            {
                var bead:IBead = _beads[i];
                if (bead == value)
                {
                    _beads.splice(i, 1);
                    return bead;
                }
            }
            return null;*/
            return removeBeadFromBeads(_beads,value, false);
        }
    
    
    
        /**
         * allow access from overrides
         */
        protected var _model:IBeadModel;
    
        /**
         * @royaleignorecoercion Class
         * @royaleignorecoercion org.apache.royale.core.IBeadModel
         */
        public function get model():Object
        {
            if (_model == null)
            {
                _model = loadBeadFromValuesManager(IBeadModel,"iBeadModel",this) as IBeadModel;
            }
            return _model;
        }
    
        /**
         * @private
         * @royaleignorecoercion org.apache.royale.core.IBead
         */
        [Bindable("modelChanged")]
        public function set model(value:Object):void
        {
            if (_model != value)
            {
                addBead(value as IBead);
                dispatchEvent(new Event("modelChanged"));
            }
        }
    }
    
	COMPILE::JS
	public class HTMLElementWrapper extends ElementWrapper
	{

        
		//--------------------------------------
		//   Property
		//--------------------------------------
        
        /**
         * allow access from overrides
         */
		protected var _model:IBeadModel;
        
        /**
         * @royaleignorecoercion Class 
         * @royaleignorecoercion org.apache.royale.core.IBeadModel
         */
        public function get model():Object
        {
            if (_model == null) 
                _model = loadBeadFromValuesManager(IBeadModel, "iBeadModel", this) as IBeadModel;
            
            return _model;
        }
        
        /**
         * @royaleignorecoercion org.apache.royale.core.IBead
         * @royaleignorecoercion org.apache.royale.core.IBeadModel
         */
        [Bindable("modelChanged")]
        public function set model(value:Object):void
        {
            if (_model != value)
            {
                _model = value as IBeadModel;

                if(value is IBead){
                    addBead(_model);
                }
                sendStrandEvent(this,"modelChanged");

            }
        }
        
	}
}
