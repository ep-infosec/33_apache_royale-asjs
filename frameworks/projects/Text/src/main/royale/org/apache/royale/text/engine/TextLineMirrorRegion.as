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
package org.apache.royale.text.engine
{
	import org.apache.royale.geom.Rectangle;
	import org.apache.royale.events.EventDispatcher;

	public class TextLineMirrorRegion
	{
		public function TextLineMirrorRegion()
		{
		}

		public function get bounds():Rectangle
		{
			return null;
		}
		public function get element():ContentElement
		{
			return null;
		}
		public function get mirror():EventDispatcher
		{
			return  null;
		}
		public function get nextRegion():TextLineMirrorRegion
		{
			return null;
		}
		public function get previousRegion():TextLineMirrorRegion
		{
			return null;
		}
		public function get textLine():ITextLine
		{
			return null;
		}
	}
}
