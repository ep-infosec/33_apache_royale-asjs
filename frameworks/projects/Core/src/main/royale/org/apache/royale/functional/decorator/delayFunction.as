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
	/**
	 * Returns a function which when run will invoke the wrapped function after a delay.
	 * Defaults to 0 which will execute at the next opportune time.
	 * In JS this uses requestAnimationFrame
	 * 
   * @royalesuppressexport
	 * @langversion 3.0
	 * @productversion Royale 0.9.9
	 * 
	 */
	public function delayFunction(method:Function, delay:Number=0):Function
	{
		return function(...args):void
		{

			function callback():void
			{
				method.apply(null,args);
			}

			COMPILE::SWF
			{
				setTimeout(function():void{
					callback();
				},delay);
			}

			COMPILE::JS
			{
				if(delay)
				{
					setTimeout(function():void{
						requestAnimationFrame(callback);
					},delay);
				}
				else
				{
					requestAnimationFrame(callback);
				}

			}

		}
	}
}