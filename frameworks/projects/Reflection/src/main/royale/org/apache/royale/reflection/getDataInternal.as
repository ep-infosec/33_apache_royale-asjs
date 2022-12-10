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
package org.apache.royale.reflection
{
    COMPILE::SWF
    {
        import flash.utils.describeType;
    }
    COMPILE::JS
    {
        import org.apache.royale.utils.Language;
    }

    /**
     *  @private
     *
     */
    COMPILE::SWF
    internal function getDataInternal(value:Object):XML {
        var untyped:* = value;
        if (value !== null && untyped !== undefined) {
            //normalize the query object to the static Class or interface level
            //numeric values have some specific range quirks:
            if (value is int && value >= -268435456 && value <= 268435455) value = int;
            while (value['constructor'] !== Class) {
                value = value['constructor'];
            }
        }
       return flash.utils.describeType(value);
    }

    /**
     *  @private
     *
     */
    COMPILE::JS
    internal function getDataInternal(value:Object, qName:String):Object {
        var data:Object = value.ROYALE_CLASS_INFO || (value.prototype ? value.prototype.ROYALE_CLASS_INFO : null);
        if (!data) {
            if (ExtraData.hasData(qName)) {
                data = ExtraData.getData(qName)['ROYALE_CLASS_INFO'];
            } else {
                var key:* = (value.constructor && value.constructor != Function && !Language.isSynthType(value)) ? value.constructor : value;
                data = ExtraData.hasData(key) ? ExtraData.getData(key)['ROYALE_CLASS_INFO'] : null;
                if (!data) {
                    key = getDefinitionByName(qName);
                    data = ExtraData.hasData(key) ? ExtraData.getData(key)['ROYALE_CLASS_INFO'] : null;
                }
            }
        }
        return data;
    }

}
