/*
// Copyright (c) 2015 Intel Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
*/
package org.trustedanalytics.atk.scoring.models

import org.apache.spark.mllib.ScoringJsonReaderWriters._
import java.io._
import org.apache.spark.mllib.classification.SVMModel
import org.trustedanalytics.atk.scoring.interfaces.{ Model, ModelLoader }
import spray.json._
import spray.json.DefaultJsonProtocol._

class SVMWithSGDModelReaderPlugin() extends ModelLoader {

  private var mySVMModel: SVMWithSGDScoreModel = _

  override def load(bytes: Array[Byte]): Model = {
    val str = new String(bytes)
    println(str)
    val json: JsValue = str.parseJson
    val svmModel = json.convertTo[SVMModel]
    mySVMModel = new SVMWithSGDScoreModel(svmModel)
    mySVMModel.asInstanceOf[Model]

  }
}