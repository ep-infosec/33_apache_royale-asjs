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
package org.apache.royale.html.beads
{
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.utils.CSSUtils;
	import org.apache.royale.html.util.getModelByType;
	
	/**
	 *  The ColorPickerWithEmptyView overrides ColorPickerView methods to visibly indicate that a selection is empty
	 *  
	 *  @viewbead
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.6
	 */
	public class ColorPickerWithEmptyView extends ColorPickerView
	{
		public function ColorPickerWithEmptyView()
		{
			super();
		}
		
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IColorModel
		 */
		override protected function colorChangeAction():void
		{
      var model:IColorModel = getModelByType(_strand,IColorModel) as IColorModel;
			var isEmpty:Boolean = isNaN(model.color);
			COMPILE::JS 
			{
				selectedColorDisplay.element.style.backgroundColor = isEmpty ? "transparent" : CSSUtils.attributeFromColor(model.color);
			}		
		}
	}
}