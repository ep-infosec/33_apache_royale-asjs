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
package org.apache.royale.functional.decorator
{
	COMPILE::SWF{
		import flash.utils.setTimeout;		
		import flash.utils.clearTimeout;		
	}
	import org.apache.royale.functional.Animated;

	/**
	 * Returns a debounced function to run after a delay.
	 * The first invocation of the function will be run after its delay.
	 * Any invocations between the first invocation and the delay will be ignored.
	 * 
   * @royalesuppressexport
	 * @langversion 3.0
	 * @productversion Royale 0.9.9
	 * 
	 */
	public function animateFunction(method:Function, fps:Number):Function
	{
		var animated:Animated = new Animated(method,fps);

		return function(...args):Animated
		{
			animated.push(args);
			animated.start();
			return animated;
		}
	}
}