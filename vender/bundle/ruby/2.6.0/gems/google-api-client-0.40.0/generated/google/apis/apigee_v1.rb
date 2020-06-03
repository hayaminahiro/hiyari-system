# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'google/apis/apigee_v1/service.rb'
require 'google/apis/apigee_v1/classes.rb'
require 'google/apis/apigee_v1/representations.rb'

module Google
  module Apis
    # Apigee API
    #
    # The Apigee API lets you programmatically manage Apigee hybrid with a set of
    # RESTful operations, including:<ul>  <li>Create, edit, and delete API proxies</
    # li>  <li>Manage users</li>  <li>Deploy and undeploy proxy revisions</li>  <li>
    # Configure environments</li></ul><p>For information on using the APIs described
    # in this section, see <a href="docs.apigee.com/hybrid/latest/api-get-started">
    # Get started using the APIs</a>.</p><p><strong>Note:</strong> This product is
    # available as a free trial for a time period of 60 days.
    #
    # @see https://cloud.google.com/apigee-api-management/
    module ApigeeV1
      VERSION = 'V1'
      REVISION = '20200521'

      # View and manage your data across Google Cloud Platform services
      AUTH_CLOUD_PLATFORM = 'https://www.googleapis.com/auth/cloud-platform'
    end
  end
end
