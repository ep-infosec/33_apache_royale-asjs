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
package org.apache.royale.html
{
	import org.apache.royale.events.Event;
    import org.apache.royale.html.beads.models.ImageAndTextModel;
    COMPILE::JS
    {
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }

    /**
     *  The ImageTextButton class implements a basic button that
     *  displays and image and text.
     *
     *  @toplevel
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
	public class ImageAndTextButton extends TextButton
	{
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
		public function ImageAndTextButton()
		{
			super();
		}

        /**
         *  @private
         *  @royaleignorecoercion org.apache.royale.html.beads.models.ImageAndTextModel
         */
        COMPILE::JS
        override public function get text():String
        {
            return ImageAndTextModel(model).text;
        }

        /**
         *  @private
         *  @royaleignorecoercion org.apache.royale.html.beads.models.ImageAndTextModel
         */
        COMPILE::JS
        override public function set text(value:String):void
        {
            ImageAndTextModel(model).text = value;
            COMPILE::JS
            {
                if(!textNode){
                    textNode = document.createTextNode(value) as Text;
                    element.appendChild(textNode);
                }
                textNode.nodeValue = "\xa0" + value;
            }
        }

        /**
         *  The URL of an icon to use in the button
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9
         *  @royaleignorecoercion org.apache.royale.html.beads.models.ImageAndTextModel
         */
        public function get image():String
        {
            return ImageAndTextModel(model).image;
        }

        /**
         *  @private
         *  @royaleignorecoercion org.apache.royale.html.beads.models.ImageAndTextModel
         */
        public function set image(value:String):void
        {
            ImageAndTextModel(model).image = value;
            COMPILE::JS
            {
                imgElement.src = value;
            }
        }

        COMPILE::JS
        protected var imgElement:HTMLImageElement;
        
        COMPILE::JS
        protected var textNode:Text;

        /**
         * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
			addElementToWrapper(this,'button');
            element.setAttribute('type', 'button');
            imgElement = document.createElement("img") as HTMLImageElement;
            element.appendChild(imgElement);
            return element;
        }

	}
}
