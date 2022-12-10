/*
 * Copyright 2010 The Closure Compiler Authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * This file was generated from Google's Externs for the Google Maps v3.11 API.
 */
package google.maps.places {

/**
 * @see [google_maps_api_v3_11]
 * @constructor  */
public class PlaceReview {

    /**
     * @see [google_maps_api_v3_11]
     */
    public function PlaceReview() {
        super();
    }

    /**
     * @see JSType - [string] 
     * @see [google_maps_api_v3_11]
     */
    public var text:String;

    /**
     * @see JSType - [string] 
     * @see [google_maps_api_v3_11]
     */
    public var author_url:String;

    /**
     * @see JSType - [string] 
     * @see [google_maps_api_v3_11]
     */
    public var author_name:String;

    /**
     * @see JSType - [(Array(google.maps.places.PlaceAspectRating|null)|null)] 
     * @see [google_maps_api_v3_11]
     */
    public var aspects:Array;

}
}
