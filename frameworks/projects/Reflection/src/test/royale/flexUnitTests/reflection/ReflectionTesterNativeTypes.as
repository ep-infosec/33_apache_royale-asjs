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
package flexUnitTests.reflection
{
    import org.apache.royale.test.asserts.*;
    import flexUnitTests.reflection.support.*;
    import org.apache.royale.reflection.*;
    import org.apache.royale.test.Runtime;
    
    /**
     * @royalesuppresspublicvarwarning
     */
    public class ReflectionTesterNativeTypes
    {
        
        public static var isJS:Boolean = COMPILE::JS;
    
        public static function getSwfVersion():uint{
            COMPILE::SWF{
                return Runtime.swfVersion;
            }
            COMPILE::JS {
                //this mimics the version of the flash player that is 11.3
                return 16
            }
        }
        
        [BeforeClass]
        public static function setUpBeforeClass():void
        {
            ExtraData.addAll();
        }
        
        [AfterClass]
        public static function tearDownAfterClass():void
        {
            ExtraData.reset();
        }
        
        [Before]
        public function setUp():void
        {

        }
        
        [After]
        public function tearDown():void
        {
        }
        
        private static function retrieveItemWithName(collection:Array, name:String):DefinitionBase
        {
            var ret:DefinitionBase;
            var i:uint = 0, l:uint = collection.length;
            for (; i < l; i++)
            {
                if (collection[i].name == name)
                {
                    ret = collection[i];
                    break;
                }
            }
            
            return ret;
        }
        
        
        [Test]
        public function testArrayClass():void
        {
            assertEquals( getQualifiedClassName(Array), "Array", "Unexpected type name");
            assertEquals( getDefinitionByName("Array"), Array, "Unexpected type");
            var def:TypeDefinition = describeType(Array);
            assertTrue( def.accessors.length == 1, "unexpected value");
            assertEquals( def.name, "Array", "Unexpected type name");
        }
    
    
        [Test]
        public function testArrayInstance():void
        {
            var inst:Array = [];
            assertEquals( getQualifiedClassName(inst), "Array", "Unexpected type name");
            
            var def:TypeDefinition = describeType([]);
            assertTrue( def.accessors.length == 1, "unexpected value");
            assertEquals( def.name, "Array", "Unexpected type name");
            
        }
    
        [Test]
        public function testStringClass():void
        {
            assertEquals( getQualifiedClassName(String), "String", "Unexpected type name");
            assertEquals( getDefinitionByName("String"), String, "Unexpected type");
            var def:TypeDefinition = describeType(String);
            assertTrue( def.accessors.length == 1, "unexpected value");
            assertEquals( def.name, "String", "Unexpected type name");
        }
    
    
        [Test]
        public function testStringInstance():void
        {
            var inst:String = '';
            assertEquals( getQualifiedClassName(inst), "String", "Unexpected type name");
    
            var def:TypeDefinition = describeType(inst);
            assertTrue( def.accessors.length == 1, "unexpected value");
            assertEquals( def.name, "String", "Unexpected type name");
        }
    
    
        [Test]
        public function testNumberClass():void
        {
            assertEquals( getQualifiedClassName(Number), "Number", "Unexpected type name");
            assertEquals( getDefinitionByName("Number"), Number, "Unexpected type");
            var def:TypeDefinition = describeType(Number);
            //player 11.2 and below has zero static methods in the Number class reflection.
            //from player 11.3 and above it has 18 (same as javascript)
            const expectedCount:uint = getSwfVersion() >= 16 ? 18 : 0;
            assertEquals( def.staticMethods.length , expectedCount, "unexpected value");
            assertEquals( def.name, "Number", "Unexpected type name");
        }
    
    
        [Test]
        public function testNumberInstance():void
        {
            var inst:Number = 1.5;
            assertEquals( getQualifiedClassName(inst), "Number", "Unexpected type name");
            
            var def:TypeDefinition = describeType(inst);
            //This is resolved as Number
            assertEquals( def.name, "Number", "Unexpected type name");
            //player 11.2 and below has zero static methods in the Number class reflection.
            //from player 11.3 and above it has 18 (same as javascript)
            const expectedCount:uint = getSwfVersion() >= 16 ? 18 : 0;
            assertEquals( def.staticMethods.length , expectedCount, "unexpected value");

        }
    
        [Test]
        public function testIntClass():void
        {
    
            assertEquals( getQualifiedClassName(int), "int", "Unexpected type name");
            assertEquals( getDefinitionByName("int"), int, "Unexpected type");
            var def:TypeDefinition = describeType(int);
            
            assertEquals( def.name, "int", "Unexpected type name");
        }
    
    
        [Test]
        public function testIntInstance():void
        {
            var inst:int = -268435456;
            
            assertEquals( getQualifiedClassName(inst), "int", "Unexpected type name");
            inst-=1;
            //resolves to Number outside boundary:
            assertEquals( getQualifiedClassName(inst), "Number", "Unexpected type name");
            inst = 268435455;
            
            assertEquals( getQualifiedClassName(inst), "int", "Unexpected type name");
            inst+=1;
            //resolves to Number outside boundary:
            assertEquals( getQualifiedClassName(inst), "Number", "Unexpected type name");
            inst = -268435456;
            
            var def:TypeDefinition = describeType(inst);

            //    RoyaleUnitTestRunner.consoleOut('def name is '+def.name);

            //This is treated as Number
            assertEquals( def.name, "int", "Unexpected type name");
        
        }
    
        [Test]
        public function testUintClass():void
        {
            assertEquals( getQualifiedClassName(uint), "uint", "Unexpected type name");
            assertEquals( getDefinitionByName("uint"), uint, "Unexpected type");
            
            var def:TypeDefinition = describeType(uint);
            assertEquals( def.name, "uint", "Unexpected type name");
        
        }
    
    
        [Test]
        public function testUintInstance():void
        {
            var inst:uint = 1;
            //resolves to Number:
            assertEquals( getQualifiedClassName(inst), "int", "Unexpected type name");
    
            var def:TypeDefinition = describeType(inst);
            //This is treated as Number
            assertEquals( def.name, "int", "Unexpected type name");
        
        }
    
    
        [Test]
        public function testSpecificVectorClass():void
        {
            assertEquals( getQualifiedClassName(Vector.<uint>), "Vector.<uint>", "Unexpected type name");
            assertEquals( getDefinitionByName("Vector.<uint>"), Vector.<uint>, "Unexpected type");
            var def:TypeDefinition = describeType(Vector.<uint>);
         //   RoyaleUnitTestRunner.consoleOut(def.toString(true));
            assertEquals( def.name, "Vector.<uint>", "Unexpected type name");
            
        }
    
    
        [Test]
        public function testSpecificVectorInstance():void
        {
            var inst:Vector.<uint> = new Vector.<uint>();
            //resolves to Number:
            assertEquals( getQualifiedClassName(inst), "Vector.<uint>", "Unexpected type name");
            
            var def:TypeDefinition = describeType(inst);
            assertEquals( def.name, "Vector.<uint>", "Unexpected type name");
        
        }


        [Test]
        public function testFunctionClass():void
        {
            assertEquals( getQualifiedClassName(Function), "Function", "Unexpected type name");
            assertEquals( getDefinitionByName("Function"), Function, "Unexpected type");

            var def:TypeDefinition = describeType(Function);
            assertEquals( def.name, "Function", "Unexpected type name");

        }


        [Test]
        public function testFunctionInstance():void
        {
            var inst:Function = testFunctionClass;
            assertEquals( getQualifiedClassName(inst), "builtin.as$0.MethodClosure", "Unexpected type name");

            var def:TypeDefinition = describeType(inst);
            assertEquals( def.name, "MethodClosure", "Unexpected type name");

            inst = testFunctionInstance;
            assertEquals( getQualifiedClassName(inst), "builtin.as$0.MethodClosure", "Unexpected type name");

            assertEquals( getQualifiedSuperclassName(inst), "Function", "Unexpected type name");

            inst = function():void{};
            assertEquals( getQualifiedClassName(inst), "Function", "Unexpected type name");

            def = describeType(inst);
            assertEquals( def.name, "Function", "Unexpected type name");

            var me:Object = this;
            inst = function():Object{return me};
            assertEquals( getQualifiedClassName(inst), "Function", "Unexpected type name");

            def = describeType(inst);
            assertEquals( def.name, "Function", "Unexpected type name");
        }


        [Test]
        public function testAncestry():void
        {
            var test:Object = Boolean;
            var def:TypeDefinition = describeType(test);

            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));
            test = String;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = Number;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = uint;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = int;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = Array;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = Vector.<*>;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = Vector.<Number>;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = Vector.<int>;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = Vector.<uint>;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Object"], true));

            test = Vector.<String>;
            def = describeType(test);
            assertTrue(containsDefinitions(def.baseClasses, ["Vector.<*>","Object"], true));


            assertEquals(getQualifiedSuperclassName(Number), 'Object', 'Unexpected Superclass name');
            assertEquals(getQualifiedSuperclassName(String), 'Object', 'Unexpected Superclass name');
            assertEquals(getQualifiedSuperclassName(uint), 'Object', 'Unexpected Superclass name');
            assertEquals(getQualifiedSuperclassName(int), 'Object', 'Unexpected Superclass name');
            assertEquals(getQualifiedSuperclassName(Function), 'Object', 'Unexpected Superclass name');
            assertEquals(getQualifiedSuperclassName(Array), 'Object', 'Unexpected Superclass name');
            assertStrictlyEquals(getQualifiedSuperclassName(Object), null, 'Unexpected Superclass name');

            var inst:Function =testFunctionInstance;
            //closure:
            assertEquals(getQualifiedSuperclassName(inst), "Function", 'Unexpected Superclass name');
            //non-closure function ref
            inst = function():void{};
            assertEquals(getQualifiedSuperclassName(inst), "Object", 'Unexpected Superclass name');
        }

        [Test]
        public function testNull():void
        {
            assertStrictlyEquals(getQualifiedClassName(null), "null", 'Unexpected class name');
            assertStrictlyEquals(getQualifiedSuperclassName(null), null, 'Unexpected Superclass name');
        }

        [Test]
        public function testUndefined():void
        {
            var val:* = undefined;
            assertStrictlyEquals(getQualifiedClassName(val), "void", 'Unexpected class name');
            assertStrictlyEquals(getQualifiedSuperclassName(val), null, 'Unexpected Superclass name');
        }




        private function containsDefinitions(collection:Array, requiredInOrder:Array, mustBeEqualLength:Boolean):Boolean {
            if (mustBeEqualLength && collection.length != requiredInOrder.length) return false;

            for (var i:uint = 0; i< collection.length; i++) {
                var typeDef:TypeDefinition = collection[i];
                if (typeDef.qualifiedName != requiredInOrder[i]) return false;
            }

            return true;
        }
    }
}