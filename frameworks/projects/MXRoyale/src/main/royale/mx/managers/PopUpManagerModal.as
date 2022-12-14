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
package mx.managers
{
  import org.apache.royale.core.IPopUpHost;
  import org.apache.royale.core.IUIBase;
  import org.apache.royale.core.IParent;
  import org.apache.royale.events.MouseEvent;
  import mx.core.IFlexDisplayObject;
  import mx.core.UIComponent;

  COMPILE::SWF{
    import flash.utils.Dictionary
  }

  public class PopUpManagerModal extends UIComponent
  {
    public function PopUpManagerModal()
    {
      super();
      typeNames = "PopUpManagerModal";
    }

    COMPILE::SWF
    private static var overlaysByPopUp:Dictionary = new Dictionary();

    COMPILE::JS
    private static var overlaysByPopUp:Map = new Map();

    // Application and View are both possible parents,
    // but there's no single interface for both that will work.
    /**
     *  @royaleignorecoercion Object
     */
    public static function show(host:IUIBase, forPopup:IFlexDisplayObject):void
    {
      var hostParent:IParent = host is IPopUpHost ? IPopUpHost(host).popUpParent : host.parent;
      var overlay:PopUpManagerModal = new PopUpManagerModal();
      COMPILE::SWF
      {
        overlay.width = (hostParent as Object).width;
        overlay.height = (hostParent as Object).height;
	  	overlay.graphics.beginFill(overlay.getStyle("backgroundColor"),overlay.getStyle("backgroundAlpha"));
		overlay.graphics.drawRect(0, 0, overlay.width, overlay.height);
	    overlay.graphics.endFill();

      }

      /* in CSS
      COMPILE::JS
      {
        var style:CSSStyleDeclaration = overlay.element.style;
        style.position = "fixed";
        style.top = "0px";
        style.left = "0px";
        style.width = "100%";
        style.height = "100%";
        style.opacity = alpha;
        style.backgroundColor = CSSUtils.attributeFromColor(color);
      }
      */
      hostParent.addElement(overlay);
      overlay.addEventListener(MouseEvent.CLICK,handleClick);
      COMPILE::SWF{
        overlaysByPopUp[forPopup] = overlay;
      }
      COMPILE::JS{
        overlaysByPopUp.set(forPopup, overlay);
      }
    }

    private static function handleClick(ev:MouseEvent):void
    {
      ev.preventDefault();
      ev.stopImmediatePropagation();
    }

    public static function remove(host:IUIBase, forPopup:IFlexDisplayObject):void
    {
      var hostParent:IParent = host is IPopUpHost ? IPopUpHost(host).popUpParent : host.parent;
      var overlay:PopUpManagerModal ;
      COMPILE::SWF{
        overlay = overlaysByPopUp[forPopup];
        delete overlaysByPopUp[forPopup];
      }
      COMPILE::JS{
        overlay = overlaysByPopUp.get(forPopup);
        overlaysByPopUp.delete(forPopup);
      }
      if (overlay){
        hostParent.removeElement(overlay);
      }
    }


  }
}