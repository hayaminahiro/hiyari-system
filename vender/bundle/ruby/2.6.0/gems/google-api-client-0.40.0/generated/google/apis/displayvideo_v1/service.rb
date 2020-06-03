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

require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module DisplayvideoV1
      # Display & Video 360 API
      #
      # Display & Video 360 API allows users to manage and create campaigns and
      #  reports.
      #
      # @example
      #    require 'google/apis/displayvideo_v1'
      #
      #    Displayvideo = Google::Apis::DisplayvideoV1 # Alias the module
      #    service = Displayvideo::DisplayVideoService.new
      #
      # @see https://developers.google.com/display-video/
      class DisplayVideoService < Google::Apis::Core::BaseService
        # @return [String]
        #  API key. Your API key identifies your project and provides you with API access,
        #  quota, and reports. Required unless you provide an OAuth 2.0 token.
        attr_accessor :key

        # @return [String]
        #  Available to use for quota purposes for server-side applications. Can be any
        #  arbitrary string assigned to a user, but should not exceed 40 characters.
        attr_accessor :quota_user

        def initialize
          super('https://displayvideo.googleapis.com/', '')
          @batch_path = 'batch'
        end
        
        # Bulk edits targeting options under a single advertiser.
        # The operation will delete the assigned targeting options provided in
        # BulkEditAdvertiserAssignedTargetingOptionsRequest.delete_requests and
        # then create the assigned targeting options provided in
        # BulkEditAdvertiserAssignedTargetingOptionsRequest.create_requests .
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser.
        # @param [Google::Apis::DisplayvideoV1::BulkEditAdvertiserAssignedTargetingOptionsRequest] bulk_edit_advertiser_assigned_targeting_options_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::BulkEditAdvertiserAssignedTargetingOptionsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::BulkEditAdvertiserAssignedTargetingOptionsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def bulk_edit_advertiser_assigned_targeting_options(advertiser_id, bulk_edit_advertiser_assigned_targeting_options_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}:bulkEditAdvertiserAssignedTargetingOptions', options)
          command.request_representation = Google::Apis::DisplayvideoV1::BulkEditAdvertiserAssignedTargetingOptionsRequest::Representation
          command.request_object = bulk_edit_advertiser_assigned_targeting_options_request_object
          command.response_representation = Google::Apis::DisplayvideoV1::BulkEditAdvertiserAssignedTargetingOptionsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::BulkEditAdvertiserAssignedTargetingOptionsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists assigned targeting options of an advertiser across targeting types.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser the line item belongs to.
        # @param [String] filter
        #   Allows filtering by assigned targeting option properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by the logical operator `OR`..
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `targetingType`
        #   Examples:
        #   * targetingType with value TARGETING_TYPE_CHANNEL
        #   `targetingType="TARGETING_TYPE_CHANNEL"`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `targetingType` (default)
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `targetingType desc`.
        # @param [Fixnum] page_size
        #   Requested page size.
        #   The size must be an integer between `1` and `5000`. If unspecified,
        #   the default is '5000'. Returns error code `INVALID_ARGUMENT` if an invalid
        #   value is specified.
        # @param [String] page_token
        #   A token that lets the client fetch the next page of results.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to
        #   `BulkListAdvertiserAssignedTargetingOptions` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::BulkListAdvertiserAssignedTargetingOptionsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::BulkListAdvertiserAssignedTargetingOptionsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def bulk_advertiser_list_advertiser_assigned_targeting_options(advertiser_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}:bulkListAdvertiserAssignedTargetingOptions', options)
          command.response_representation = Google::Apis::DisplayvideoV1::BulkListAdvertiserAssignedTargetingOptionsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::BulkListAdvertiserAssignedTargetingOptionsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new advertiser.
        # Returns the newly created advertiser if successful.
        # This method can take up to 180 seconds to complete.
        # @param [Google::Apis::DisplayvideoV1::Advertiser] advertiser_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Advertiser] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Advertiser]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_advertiser(advertiser_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers', options)
          command.request_representation = Google::Apis::DisplayvideoV1::Advertiser::Representation
          command.request_object = advertiser_object
          command.response_representation = Google::Apis::DisplayvideoV1::Advertiser::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Advertiser
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes an advertiser.
        # Deleting an advertiser will delete all of its child resources, for example,
        # campaigns, insertion orders and line items.
        # A deleted advertiser cannot be recovered.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser we need to delete.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_advertiser(advertiser_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1/advertisers/{+advertiserId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Empty::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Empty
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an advertiser.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Advertiser] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Advertiser]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser(advertiser_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Advertiser::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Advertiser
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists advertisers that are accessible to the current user.
        # The order is defined by the order_by
        # parameter.
        # A single partner_id is required.
        # Cross-partner listing is not supported.
        # @param [String] filter
        #   Allows filtering by advertiser properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `AND` or `OR` logical operators. A
        #   sequence of restrictions implicitly uses `AND`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `entityStatus`
        #   Examples:
        #   * All active advertisers under a partner:
        #   `entityStatus="ENTITY_STATUS_ACTIVE"`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `displayName` (default)
        #   * `entityStatus`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. For example,
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListAdvertisers` method.
        #   If not specified, the first page of results will be returned.
        # @param [Fixnum] partner_id
        #   Required. The ID of the partner that the fetched advertisers should all belong
        #   to.
        #   The system only supports listing advertisers for one partner at a time.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListAdvertisersResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListAdvertisersResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertisers(filter: nil, order_by: nil, page_size: nil, page_token: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListAdvertisersResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListAdvertisersResponse
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates an existing advertiser.
        # Returns the updated advertiser if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser. Assigned by the system.
        # @param [Google::Apis::DisplayvideoV1::Advertiser] advertiser_object
        # @param [String] update_mask
        #   Required. The mask to control which fields to update.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Advertiser] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Advertiser]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_advertiser(advertiser_id, advertiser_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1/advertisers/{+advertiserId}', options)
          command.request_representation = Google::Apis::DisplayvideoV1::Advertiser::Representation
          command.request_object = advertiser_object
          command.response_representation = Google::Apis::DisplayvideoV1::Advertiser::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Advertiser
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Uploads an asset.
        # Returns the ID of the newly uploaded asset if successful.
        # The asset file size should be no more than 10 MB for images, 200 MB for
        # ZIP files, and 1 GB for videos.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser this asset belongs to.
        # @param [Google::Apis::DisplayvideoV1::CreateAssetRequest] create_asset_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [IO, String] upload_source
        #   IO stream or filename containing content to upload
        # @param [String] content_type
        #   Content type of the uploaded content.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::CreateAssetResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::CreateAssetResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def upload_advertiser_asset(advertiser_id, create_asset_request_object = nil, fields: nil, quota_user: nil, upload_source: nil, content_type: nil, options: nil, &block)
          if upload_source.nil?
            command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/assets', options)
          else
            command = make_upload_command(:post, 'v1/advertisers/{+advertiserId}/assets', options)
            command.upload_source = upload_source
            command.upload_content_type = content_type
          end
          command.request_representation = Google::Apis::DisplayvideoV1::CreateAssetRequest::Representation
          command.request_object = create_asset_request_object
          command.response_representation = Google::Apis::DisplayvideoV1::CreateAssetResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::CreateAssetResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new campaign.
        # Returns the newly created campaign if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the campaign belongs to.
        # @param [Google::Apis::DisplayvideoV1::Campaign] campaign_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Campaign] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Campaign]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_advertiser_campaign(advertiser_id, campaign_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/campaigns', options)
          command.request_representation = Google::Apis::DisplayvideoV1::Campaign::Representation
          command.request_object = campaign_object
          command.response_representation = Google::Apis::DisplayvideoV1::Campaign::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Campaign
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Permanently deletes a campaign. A deleted campaign cannot be recovered.
        # The campaign should be archived first, i.e. set
        # entity_status to `ENTITY_STATUS_ARCHIVED`, to be
        # able to delete it.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser this campaign belongs to.
        # @param [Fixnum] campaign_id
        #   The ID of the campaign we need to delete.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_advertiser_campaign(advertiser_id, campaign_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1/advertisers/{+advertiserId}/campaigns/{+campaignId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Empty::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Empty
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['campaignId'] = campaign_id unless campaign_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a campaign.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser this campaign belongs to.
        # @param [Fixnum] campaign_id
        #   Required. The ID of the campaign to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Campaign] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Campaign]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_campaign(advertiser_id, campaign_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/campaigns/{+campaignId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Campaign::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Campaign
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['campaignId'] = campaign_id unless campaign_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists campaigns in an advertiser.
        # The order is defined by the order_by
        # parameter.
        # If a filter by
        # entity_status is not specified, campaigns with
        # `ENTITY_STATUS_ARCHIVED` will not be included in the results.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser to list campaigns for.
        # @param [String] filter
        #   Allows filtering by campaign properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `AND` or `OR` logical operators. A
        #   sequence of restrictions implicitly uses `AND`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `entityStatus`
        #   Examples:
        #   * All `ENTITY_STATUS_ACTIVE` or `ENTITY_STATUS_PAUSED` campaigns under an
        #   advertiser:
        #   `(entityStatus="ENTITY_STATUS_ACTIVE" OR
        #   entityStatus="ENTITY_STATUS_PAUSED")`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `displayName` (default)
        #   * `entityStatus`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token returned from the
        #   previous call to `ListCampaigns` method. If not specified, the first page
        #   of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListCampaignsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListCampaignsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_campaigns(advertiser_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/campaigns', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListCampaignsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListCampaignsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates an existing campaign.
        # Returns the updated campaign if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the campaign belongs to.
        # @param [Fixnum] campaign_id
        #   Output only. The unique ID of the campaign. Assigned by the system.
        # @param [Google::Apis::DisplayvideoV1::Campaign] campaign_object
        # @param [String] update_mask
        #   Required. The mask to control which fields to update.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Campaign] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Campaign]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_advertiser_campaign(advertiser_id, campaign_id, campaign_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1/advertisers/{+advertiserId}/campaigns/{+campaignId}', options)
          command.request_representation = Google::Apis::DisplayvideoV1::Campaign::Representation
          command.request_object = campaign_object
          command.response_representation = Google::Apis::DisplayvideoV1::Campaign::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Campaign
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['campaignId'] = campaign_id unless campaign_id.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a channel for a partner or advertiser.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that owns the fetched channel.
        # @param [Fixnum] channel_id
        #   Required. The ID of the channel to fetch.
        # @param [Fixnum] partner_id
        #   The ID of the partner that owns the fetched channel.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Channel] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Channel]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_channel(advertiser_id, channel_id, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/channels/{+channelId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Channel::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Channel
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['channelId'] = channel_id unless channel_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists channels for a partner or advertiser.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that owns the channels.
        # @param [String] filter
        #   Allows filtering by channel fields.
        #   Supported syntax:
        #   * Filter expressions for channel currently can only contain at most one
        #   * restriction.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `CONTAINS (:)`.
        #   * Supported fields:
        #   - `displayName`
        #   Examples:
        #   * All channels for which the display name contains "google":
        #   `displayName : "google"`.
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `displayName` (default)
        #   * `channelId`
        #   The default sorting order is ascending. To specify descending order for a
        #   field, a suffix " desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token returned from the
        #   previous call to `ListChannels` method. If not specified, the first page
        #   of results will be returned.
        # @param [Fixnum] partner_id
        #   The ID of the partner that owns the channels.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListChannelsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListChannelsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_channels(advertiser_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/channels', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListChannelsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListChannelsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new creative.
        # Returns the newly created creative if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the creative belongs to.
        # @param [Google::Apis::DisplayvideoV1::Creative] creative_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Creative] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Creative]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_advertiser_creative(advertiser_id, creative_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/creatives', options)
          command.request_representation = Google::Apis::DisplayvideoV1::Creative::Representation
          command.request_object = creative_object
          command.response_representation = Google::Apis::DisplayvideoV1::Creative::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Creative
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes a creative.
        # Returns error code `NOT_FOUND` if the creative does not exist.
        # The creative should be archived first, i.e. set
        # entity_status to `ENTITY_STATUS_ARCHIVED`, before
        # it can be deleted.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser this creative belongs to.
        # @param [Fixnum] creative_id
        #   The ID of the creative to be deleted.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_advertiser_creative(advertiser_id, creative_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1/advertisers/{+advertiserId}/creatives/{+creativeId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Empty::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Empty
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['creativeId'] = creative_id unless creative_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a creative.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser this creative belongs to.
        # @param [Fixnum] creative_id
        #   Required. The ID of the creative to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Creative] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Creative]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_creative(advertiser_id, creative_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/creatives/{+creativeId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Creative::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Creative
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['creativeId'] = creative_id unless creative_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists creatives in an advertiser.
        # The order is defined by the order_by
        # parameter.
        # If a filter by
        # entity_status is not specified, creatives with
        # `ENTITY_STATUS_ARCHIVED` will not be included in the results.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser to list creatives for.
        # @param [String] filter
        #   Allows filtering by creative properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restriction for the same field must be combined by `OR`.
        #   * Restriction for different fields must be combined by `AND`.
        #   * Between `(` and `)` there can only be restrictions combined by `OR`
        #   for the same field.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)` for the following fields:
        #   - `entityStatus`
        #   - `creativeType`.
        #   - `dimensions`
        #   - `minDuration`
        #   - `maxDuration`
        #   - `approvalStatus`
        #   - `exchangeReviewStatus`
        #   - `dynamic`
        #   * The operator must be `HAS (:)` for the following fields:
        #   - `lineItemIds`
        #   * For `entityStatus`, `minDuration`, `maxDuration`, and `dynamic` there may
        #   be at most one restriction.
        #   * For `dimensions`, the value is in the form of `"`width`x`height`"`.
        #   * For `exchangeReviewStatus`, the value is in the form of
        #   ``exchange`-`reviewStatus``.
        #   * For `minDuration` and `maxDuration`, the value is in the form of
        #   `"`duration`s"`. Only seconds are supported with millisecond granularity.
        #   * There may be multiple `lineItemIds` restrictions in order to search
        #   against multiple possible line item IDs.
        #   Examples:
        #   * All native creatives: `creativeType="CREATIVE_TYPE_NATIVE"`
        #   * All active creatives with 300x400 or 50x100 dimensions:
        #   `entityStatus="ENTITY_STATUS_ACTIVE" AND (dimensions="300x400"
        #   OR dimensions="50x100")`
        #   * All dynamic creatives that are approved by AdX or
        #   AppNexus, with a minimum duration of 5 seconds and 200ms.
        #   `dynamic="true" AND minDuration="5.2s" AND
        #   (exchangeReviewStatus="EXCHANGE_GOOGLE_AD_MANAGER-REVIEW_STATUS_APPROVED"
        #   OR exchangeReviewStatus="EXCHANGE_APPNEXUS-REVIEW_STATUS_APPROVED")`
        #   * All video creatives that are associated with line item ID 1 or 2:
        #   creativeType="CREATIVE_TYPE_VIDEO" AND (lineItemIds:1 OR lineItemIds:2)
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `creativeId` (default)
        #   * `createTime`
        #   * `mediaDuration`
        #   * `dimensions` (sorts by width first, then by height)
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name.
        #   Example: `createTime desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListCreatives` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListCreativesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListCreativesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_creatives(advertiser_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/creatives', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListCreativesResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListCreativesResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates an existing creative.
        # Returns the updated creative if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the creative belongs to.
        # @param [Fixnum] creative_id
        #   Output only. The unique ID of the creative. Assigned by the system.
        # @param [Google::Apis::DisplayvideoV1::Creative] creative_object
        # @param [String] update_mask
        #   Required. The mask to control which fields to update.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Creative] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Creative]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_advertiser_creative(advertiser_id, creative_id, creative_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1/advertisers/{+advertiserId}/creatives/{+creativeId}', options)
          command.request_representation = Google::Apis::DisplayvideoV1::Creative::Representation
          command.request_object = creative_object
          command.response_representation = Google::Apis::DisplayvideoV1::Creative::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Creative
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['creativeId'] = creative_id unless creative_id.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new insertion order.
        # Returns the newly created insertion order if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the insertion order belongs to.
        # @param [Google::Apis::DisplayvideoV1::InsertionOrder] insertion_order_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::InsertionOrder] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::InsertionOrder]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_advertiser_insertion_order(advertiser_id, insertion_order_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/insertionOrders', options)
          command.request_representation = Google::Apis::DisplayvideoV1::InsertionOrder::Representation
          command.request_object = insertion_order_object
          command.response_representation = Google::Apis::DisplayvideoV1::InsertionOrder::Representation
          command.response_class = Google::Apis::DisplayvideoV1::InsertionOrder
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes an insertion order.
        # Returns error code `NOT_FOUND` if the insertion order does not exist.
        # The insertion order should be archived first, i.e. set
        # entity_status to `ENTITY_STATUS_ARCHIVED`,
        # to be able to delete it.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser this insertion order belongs to.
        # @param [Fixnum] insertion_order_id
        #   The ID of the insertion order we need to delete.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_advertiser_insertion_order(advertiser_id, insertion_order_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1/advertisers/{+advertiserId}/insertionOrders/{+insertionOrderId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Empty::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Empty
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['insertionOrderId'] = insertion_order_id unless insertion_order_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an insertion order.
        # Returns error code `NOT_FOUND` if the insertion order does not exist.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser this insertion order belongs to.
        # @param [Fixnum] insertion_order_id
        #   Required. The ID of the insertion order to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::InsertionOrder] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::InsertionOrder]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_insertion_order(advertiser_id, insertion_order_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/insertionOrders/{+insertionOrderId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::InsertionOrder::Representation
          command.response_class = Google::Apis::DisplayvideoV1::InsertionOrder
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['insertionOrderId'] = insertion_order_id unless insertion_order_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists insertion orders in an advertiser.
        # The order is defined by the order_by
        # parameter.
        # If a filter by
        # entity_status is not specified, insertion
        # orders with `ENTITY_STATUS_ARCHIVED` will not be included in the results.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser to list insertion orders for.
        # @param [String] filter
        #   Allows filtering by insertion order properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `AND` or `OR` logical operators. A
        #   sequence of restrictions implicitly uses `AND`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `campaignId`
        #   - `entityStatus`
        #   Examples:
        #   * All insertion orders under a campaign: `campaignId="1234"`
        #   * All `ENTITY_STATUS_ACTIVE` or `ENTITY_STATUS_PAUSED` insertion orders
        #   under an advertiser:
        #   `(entityStatus="ENTITY_STATUS_ACTIVE" OR
        #   entityStatus="ENTITY_STATUS_PAUSED")`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * "displayName" (default)
        #   * "entityStatus"
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token returned
        #   from the previous call to `ListInsertionOrders` method. If not specified,
        #   the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListInsertionOrdersResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListInsertionOrdersResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_insertion_orders(advertiser_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/insertionOrders', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListInsertionOrdersResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListInsertionOrdersResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates an existing insertion order.
        # Returns the updated insertion order if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the insertion order belongs to.
        # @param [Fixnum] insertion_order_id
        #   Output only. The unique ID of the insertion order. Assigned by the system.
        # @param [Google::Apis::DisplayvideoV1::InsertionOrder] insertion_order_object
        # @param [String] update_mask
        #   Required. The mask to control which fields to update.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::InsertionOrder] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::InsertionOrder]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_advertiser_insertion_order(advertiser_id, insertion_order_id, insertion_order_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1/advertisers/{+advertiserId}/insertionOrders/{+insertionOrderId}', options)
          command.request_representation = Google::Apis::DisplayvideoV1::InsertionOrder::Representation
          command.request_object = insertion_order_object
          command.response_representation = Google::Apis::DisplayvideoV1::InsertionOrder::Representation
          command.response_class = Google::Apis::DisplayvideoV1::InsertionOrder
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['insertionOrderId'] = insertion_order_id unless insertion_order_id.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Bulk edits targeting options under a single line item.
        # The operation will delete the assigned targeting options provided in
        # BulkEditLineItemAssignedTargetingOptionsRequest.delete_requests and
        # then create the assigned targeting options provided in
        # BulkEditLineItemAssignedTargetingOptionsRequest.create_requests .
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser the line item belongs to.
        # @param [Fixnum] line_item_id
        #   Required. The ID of the line item the assigned targeting option will belong to.
        # @param [Google::Apis::DisplayvideoV1::BulkEditLineItemAssignedTargetingOptionsRequest] bulk_edit_line_item_assigned_targeting_options_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::BulkEditLineItemAssignedTargetingOptionsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::BulkEditLineItemAssignedTargetingOptionsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def bulk_edit_line_item_assigned_targeting_options(advertiser_id, line_item_id, bulk_edit_line_item_assigned_targeting_options_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}:bulkEditLineItemAssignedTargetingOptions', options)
          command.request_representation = Google::Apis::DisplayvideoV1::BulkEditLineItemAssignedTargetingOptionsRequest::Representation
          command.request_object = bulk_edit_line_item_assigned_targeting_options_request_object
          command.response_representation = Google::Apis::DisplayvideoV1::BulkEditLineItemAssignedTargetingOptionsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::BulkEditLineItemAssignedTargetingOptionsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists assigned targeting options of a line item across targeting types.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser the line item belongs to.
        # @param [Fixnum] line_item_id
        #   Required. The ID of the line item to list assigned targeting options for.
        # @param [String] filter
        #   Allows filtering by assigned targeting option properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by the logical operator `OR` on the same
        #   field.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `targetingType`
        #   - `inheritance`
        #   Examples:
        #   * AssignedTargetingOptions of targeting type
        #   TARGETING_TYPE_PROXIMITY_LOCATION_LIST or TARGETING_TYPE_CHANNEL
        #   `targetingType="TARGETING_TYPE_PROXIMITY_LOCATION_LIST" OR
        #   targetingType="TARGETING_TYPE_CHANNEL"`
        #   * AssignedTargetingOptions with inheritance status of NOT_INHERITED or
        #   INHERITED_FROM_PARTNER
        #   `inheritance="NOT_INHERITED" OR inheritance="INHERITED_FROM_PARTNER"`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `targetingType` (default)
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `targetingType desc`.
        # @param [Fixnum] page_size
        #   Requested page size.
        #   The size must be an integer between `1` and `5000`. If unspecified,
        #   the default is '5000'. Returns error code `INVALID_ARGUMENT` if an invalid
        #   value is specified.
        # @param [String] page_token
        #   A token that lets the client fetch the next page of results.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to
        #   `BulkListLineItemAssignedTargetingOptions` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::BulkListLineItemAssignedTargetingOptionsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::BulkListLineItemAssignedTargetingOptionsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def bulk_advertiser_line_item_list_line_item_assigned_targeting_options(advertiser_id, line_item_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}:bulkListLineItemAssignedTargetingOptions', options)
          command.response_representation = Google::Apis::DisplayvideoV1::BulkListLineItemAssignedTargetingOptionsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::BulkListLineItemAssignedTargetingOptionsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates a new line item.
        # Returns the newly created line item if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the line item belongs to.
        # @param [Google::Apis::DisplayvideoV1::LineItem] line_item_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::LineItem] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::LineItem]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_advertiser_line_item(advertiser_id, line_item_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/lineItems', options)
          command.request_representation = Google::Apis::DisplayvideoV1::LineItem::Representation
          command.request_object = line_item_object
          command.response_representation = Google::Apis::DisplayvideoV1::LineItem::Representation
          command.response_class = Google::Apis::DisplayvideoV1::LineItem
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes a line item.
        # Returns error code `NOT_FOUND` if the line item does not exist.
        # The line item should be archived first, i.e. set
        # entity_status to `ENTITY_STATUS_ARCHIVED`, to be
        # able to delete it.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser this line item belongs to.
        # @param [Fixnum] line_item_id
        #   The ID of the line item we need to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_advertiser_line_item(advertiser_id, line_item_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Empty::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Empty
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a line item.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser this line item belongs to.
        # @param [Fixnum] line_item_id
        #   Required. The ID of the line item to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::LineItem] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::LineItem]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_line_item(advertiser_id, line_item_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::LineItem::Representation
          command.response_class = Google::Apis::DisplayvideoV1::LineItem
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists line items in an advertiser.
        # The order is defined by the order_by
        # parameter.
        # If a filter by
        # entity_status is not specified, line items with
        # `ENTITY_STATUS_ARCHIVED` will not be included in the results.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser to list line items for.
        # @param [String] filter
        #   Allows filtering by line item properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `AND` or `OR` logical operators. A
        #   sequence of restrictions implicitly uses `AND`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `campaignId`
        #   - `insertionOrderId`
        #   - `entityStatus`
        #   - `lineItemType`.
        #   Examples:
        #   * All line items under an insertion order: `insertionOrderId="1234"`
        #   * All `ENTITY_STATUS_ACTIVE` or `ENTITY_STATUS_PAUSED`
        #   and `LINE_ITEM_TYPE_DISPLAY_DEFAULT` line items under an advertiser:
        #   `(entityStatus="ENTITY_STATUS_ACTIVE" OR
        #   entityStatus="ENTITY_STATUS_PAUSED") AND
        #   lineItemType="LINE_ITEM_TYPE_DISPLAY_DEFAULT"`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * "displayName" (default)
        #   * "entityStatus"
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListLineItems` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListLineItemsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListLineItemsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_line_items(advertiser_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/lineItems', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListLineItemsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListLineItemsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates an existing line item.
        # Returns the updated line item if successful.
        # @param [Fixnum] advertiser_id
        #   Output only. The unique ID of the advertiser the line item belongs to.
        # @param [Fixnum] line_item_id
        #   Output only. The unique ID of the line item. Assigned by the system.
        # @param [Google::Apis::DisplayvideoV1::LineItem] line_item_object
        # @param [String] update_mask
        #   Required. The mask to control which fields to update.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::LineItem] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::LineItem]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_advertiser_line_item(advertiser_id, line_item_id, line_item_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}', options)
          command.request_representation = Google::Apis::DisplayvideoV1::LineItem::Representation
          command.request_object = line_item_object
          command.response_representation = Google::Apis::DisplayvideoV1::LineItem::Representation
          command.response_class = Google::Apis::DisplayvideoV1::LineItem
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Assigns a targeting option to a line item.
        # Returns the assigned targeting option if successful.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser the line item belongs to.
        # @param [Fixnum] line_item_id
        #   Required. The ID of the line item the assigned targeting option will belong to.
        # @param [String] targeting_type
        #   Required. Identifies the type of this assigned targeting option.
        # @param [Google::Apis::DisplayvideoV1::AssignedTargetingOption] assigned_targeting_option_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::AssignedTargetingOption] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::AssignedTargetingOption]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_advertiser_line_item_targeting_type_assigned_targeting_option(advertiser_id, line_item_id, targeting_type, assigned_targeting_option_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}/targetingTypes/{+targetingType}/assignedTargetingOptions', options)
          command.request_representation = Google::Apis::DisplayvideoV1::AssignedTargetingOption::Representation
          command.request_object = assigned_targeting_option_object
          command.response_representation = Google::Apis::DisplayvideoV1::AssignedTargetingOption::Representation
          command.response_class = Google::Apis::DisplayvideoV1::AssignedTargetingOption
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes an assigned targeting option from a line item.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser the line item belongs to.
        # @param [Fixnum] line_item_id
        #   Required. The ID of the line item the assigned targeting option belongs to.
        # @param [String] targeting_type
        #   Required. Identifies the type of this assigned targeting option.
        # @param [String] assigned_targeting_option_id
        #   Required. The ID of the assigned targeting option to delete.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_advertiser_line_item_targeting_type_assigned_targeting_option(advertiser_id, line_item_id, targeting_type, assigned_targeting_option_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}/targetingTypes/{+targetingType}/assignedTargetingOptions/{+assignedTargetingOptionId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Empty::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Empty
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.params['assignedTargetingOptionId'] = assigned_targeting_option_id unless assigned_targeting_option_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a single targeting option assigned to a line item.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser the line item belongs to.
        # @param [Fixnum] line_item_id
        #   Required. The ID of the line item the assigned targeting option belongs to.
        # @param [String] targeting_type
        #   Required. Identifies the type of this assigned targeting option.
        # @param [String] assigned_targeting_option_id
        #   Required. An identifier unique to the targeting type in this line item that
        #   identifies the assigned targeting option being requested.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::AssignedTargetingOption] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::AssignedTargetingOption]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_line_item_targeting_type_assigned_targeting_option(advertiser_id, line_item_id, targeting_type, assigned_targeting_option_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}/targetingTypes/{+targetingType}/assignedTargetingOptions/{+assignedTargetingOptionId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::AssignedTargetingOption::Representation
          command.response_class = Google::Apis::DisplayvideoV1::AssignedTargetingOption
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.params['assignedTargetingOptionId'] = assigned_targeting_option_id unless assigned_targeting_option_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists the targeting options assigned to a line item.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser the line item belongs to.
        # @param [Fixnum] line_item_id
        #   Required. The ID of the line item to list assigned targeting options for.
        # @param [String] targeting_type
        #   Required. Identifies the type of assigned targeting options to list.
        # @param [String] filter
        #   Allows filtering by assigned targeting option properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by the logical operator `OR`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `assignedTargetingOptionId`
        #   - `inheritance`
        #   Examples:
        #   * AssignedTargetingOptions with ID 1 or 2
        #   `assignedTargetingOptionId="1" OR assignedTargetingOptionId="2"`
        #   * AssignedTargetingOptions with inheritance status of NOT_INHERITED or
        #   INHERITED_FROM_PARTNER
        #   `inheritance="NOT_INHERITED" OR inheritance="INHERITED_FROM_PARTNER"`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `assignedTargetingOptionId` (default)
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `assignedTargetingOptionId desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListLineItemAssignedTargetingOptions`
        #   method. If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListLineItemAssignedTargetingOptionsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListLineItemAssignedTargetingOptionsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_line_item_targeting_type_assigned_targeting_options(advertiser_id, line_item_id, targeting_type, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/lineItems/{+lineItemId}/targetingTypes/{+targetingType}/assignedTargetingOptions', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListLineItemAssignedTargetingOptionsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListLineItemAssignedTargetingOptionsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['lineItemId'] = line_item_id unless line_item_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a location list.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the DV360 advertiser to which the fetched location list
        #   belongs.
        # @param [Fixnum] location_list_id
        #   Required. The ID of the location list to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::LocationList] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::LocationList]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_location_list(advertiser_id, location_list_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/locationLists/{+locationListId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::LocationList::Representation
          command.response_class = Google::Apis::DisplayvideoV1::LocationList
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['locationListId'] = location_list_id unless location_list_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists location lists based on a given advertiser id.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the DV360 advertiser to which the fetched location lists
        #   belong.
        # @param [String] filter
        #   Allows filtering by location list fields.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `AND` or `OR` logical operators. A
        #   sequence of restrictions implicitly uses `AND`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `locationType`
        #   Examples:
        #   * All regional location list:
        #   `locationType="TARGETING_LOCATION_TYPE_REGIONAL"`
        #   * All proximity location list:
        #   `locationType="TARGETING_LOCATION_TYPE_PROXIMITY"`
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `locationListId` (default)
        #   * `displayName`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`.
        #   Defaults to `100` if not set. Returns error code `INVALID_ARGUMENT` if an
        #   invalid value is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListLocationLists` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListLocationListsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListLocationListsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_location_lists(advertiser_id, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/locationLists', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListLocationListsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListLocationListsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a negative keyword list given an advertiser ID and a negative keyword
        # list ID.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the DV360 advertiser to which the fetched negative keyword
        #   list
        #   belongs.
        # @param [Fixnum] negative_keyword_list_id
        #   Required. The ID of the negative keyword list to fetch.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::NegativeKeywordList] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::NegativeKeywordList]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_negative_keyword_list(advertiser_id, negative_keyword_list_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/negativeKeywordLists/{+negativeKeywordListId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::NegativeKeywordList::Representation
          command.response_class = Google::Apis::DisplayvideoV1::NegativeKeywordList
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['negativeKeywordListId'] = negative_keyword_list_id unless negative_keyword_list_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists negative keyword lists based on a given advertiser id.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the DV360 advertiser to which the fetched negative keyword
        #   lists
        #   belong.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`.
        #   Defaults to `100` if not set. Returns error code `INVALID_ARGUMENT` if an
        #   invalid value is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListNegativeKeywordLists` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListNegativeKeywordListsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListNegativeKeywordListsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_negative_keyword_lists(advertiser_id, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/negativeKeywordLists', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListNegativeKeywordListsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListNegativeKeywordListsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Assigns a targeting option to an advertiser.
        # Returns the assigned targeting option if successful.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser.
        # @param [String] targeting_type
        #   Required. Identifies the type of this assigned targeting option.
        # @param [Google::Apis::DisplayvideoV1::AssignedTargetingOption] assigned_targeting_option_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::AssignedTargetingOption] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::AssignedTargetingOption]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_advertiser_targeting_type_assigned_targeting_option(advertiser_id, targeting_type, assigned_targeting_option_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/advertisers/{+advertiserId}/targetingTypes/{+targetingType}/assignedTargetingOptions', options)
          command.request_representation = Google::Apis::DisplayvideoV1::AssignedTargetingOption::Representation
          command.request_object = assigned_targeting_option_object
          command.response_representation = Google::Apis::DisplayvideoV1::AssignedTargetingOption::Representation
          command.response_class = Google::Apis::DisplayvideoV1::AssignedTargetingOption
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes an assigned targeting option from an advertiser.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser.
        # @param [String] targeting_type
        #   Required. Identifies the type of this assigned targeting option.
        # @param [String] assigned_targeting_option_id
        #   Required. The ID of the assigned targeting option to delete.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_advertiser_targeting_type_assigned_targeting_option(advertiser_id, targeting_type, assigned_targeting_option_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1/advertisers/{+advertiserId}/targetingTypes/{+targetingType}/assignedTargetingOptions/{+assignedTargetingOptionId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Empty::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Empty
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.params['assignedTargetingOptionId'] = assigned_targeting_option_id unless assigned_targeting_option_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a single targeting option assigned to an advertiser.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser.
        # @param [String] targeting_type
        #   Required. Identifies the type of this assigned targeting option.
        # @param [String] assigned_targeting_option_id
        #   Required. An identifier unique to the targeting type in this advertiser that
        #   identifies the assigned targeting option being requested.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::AssignedTargetingOption] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::AssignedTargetingOption]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_advertiser_targeting_type_assigned_targeting_option(advertiser_id, targeting_type, assigned_targeting_option_id, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/targetingTypes/{+targetingType}/assignedTargetingOptions/{+assignedTargetingOptionId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::AssignedTargetingOption::Representation
          command.response_class = Google::Apis::DisplayvideoV1::AssignedTargetingOption
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.params['assignedTargetingOptionId'] = assigned_targeting_option_id unless assigned_targeting_option_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists the targeting options assigned to an advertiser.
        # @param [Fixnum] advertiser_id
        #   Required. The ID of the advertiser.
        # @param [String] targeting_type
        #   Required. Identifies the type of assigned targeting options to list.
        # @param [String] filter
        #   Allows filtering by assigned targeting option properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by the logical operator `OR`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `assignedTargetingOptionId`
        #   Examples:
        #   * AssignedTargetingOption with ID 123456
        #   `assignedTargetingOptionId="123456"`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `assignedTargetingOptionId` (default)
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `assignedTargetingOptionId desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListAdvertiserAssignedTargetingOptions`
        #   method. If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListAdvertiserAssignedTargetingOptionsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListAdvertiserAssignedTargetingOptionsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_advertiser_targeting_type_assigned_targeting_options(advertiser_id, targeting_type, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/advertisers/{+advertiserId}/targetingTypes/{+targetingType}/assignedTargetingOptions', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListAdvertiserAssignedTargetingOptionsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListAdvertiserAssignedTargetingOptionsResponse
          command.params['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a combined audience.
        # @param [Fixnum] combined_audience_id
        #   Required. The ID of the combined audience to fetch.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the fetched combined
        #   audience.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the fetched combined audience.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::CombinedAudience] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::CombinedAudience]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_combined_audience(combined_audience_id, advertiser_id: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/combinedAudiences/{+combinedAudienceId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::CombinedAudience::Representation
          command.response_class = Google::Apis::DisplayvideoV1::CombinedAudience
          command.params['combinedAudienceId'] = combined_audience_id unless combined_audience_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists combined audiences.
        # The order is defined by the
        # order_by parameter.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the fetched combined
        #   audiences.
        # @param [String] filter
        #   Allows filtering by combined audience fields.
        #   Supported syntax:
        #   * Filter expressions for combined audiences currently can only contain at
        #   most one restriction.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `CONTAINS (:)`.
        #   * Supported fields:
        #   - `displayName`
        #   Examples:
        #   * All combined audiences for which the display name contains "Google":
        #   `displayName : "Google"`.
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `combinedAudienceId` (default)
        #   * `displayName`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListCombinedAudiences` method.
        #   If not specified, the first page of results will be returned.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the fetched combined audiences.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListCombinedAudiencesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListCombinedAudiencesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_combined_audiences(advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/combinedAudiences', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListCombinedAudiencesResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListCombinedAudiencesResponse
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a custom list.
        # @param [Fixnum] custom_list_id
        #   Required. The ID of the custom list to fetch.
        # @param [Fixnum] advertiser_id
        #   The ID of the DV360 advertiser that has access to the fetched custom
        #   lists.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::CustomList] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::CustomList]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_custom_list(custom_list_id, advertiser_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/customLists/{+customListId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::CustomList::Representation
          command.response_class = Google::Apis::DisplayvideoV1::CustomList
          command.params['customListId'] = custom_list_id unless custom_list_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists custom lists.
        # The order is defined by the order_by
        # parameter.
        # @param [Fixnum] advertiser_id
        #   The ID of the DV360 advertiser that has access to the fetched custom
        #   lists.
        # @param [String] filter
        #   Allows filtering by custom list fields.
        #   Supported syntax:
        #   * Filter expressions for custom lists currently can only contain at
        #   most one restriction.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `CONTAINS (:)`.
        #   * Supported fields:
        #   - `displayName`
        #   Examples:
        #   * All custom lists for which the display name contains "Google":
        #   `displayName : "Google"`.
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `customListId` (default)
        #   * `displayName`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListCustomLists` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListCustomListsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListCustomListsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_custom_lists(advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/customLists', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListCustomListsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListCustomListsResponse
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a first and third party audience.
        # @param [Fixnum] first_and_third_party_audience_id
        #   Required. The ID of the first and third party audience to fetch.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the fetched first and
        #   third party audience.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the fetched first and
        #   third party audience.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::FirstAndThirdPartyAudience] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::FirstAndThirdPartyAudience]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_first_and_third_party_audience(first_and_third_party_audience_id, advertiser_id: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/firstAndThirdPartyAudiences/{+firstAndThirdPartyAudienceId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::FirstAndThirdPartyAudience::Representation
          command.response_class = Google::Apis::DisplayvideoV1::FirstAndThirdPartyAudience
          command.params['firstAndThirdPartyAudienceId'] = first_and_third_party_audience_id unless first_and_third_party_audience_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists first and third party audiences.
        # The order is defined by the
        # order_by parameter.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the fetched first and
        #   third party audiences.
        # @param [String] filter
        #   Allows filtering by first and third party audience fields.
        #   Supported syntax:
        #   * Filter expressions for first and third party audiences currently can
        #   only contain at most one restriction.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `CONTAINS (:)`.
        #   * Supported fields:
        #   - `displayName`
        #   Examples:
        #   * All first and third party audiences for which the display name contains
        #   "Google": `displayName : "Google"`.
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `firstAndThirdPartyAudienceId` (default)
        #   * `displayName`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListFirstAndThirdPartyAudiences`
        #   method. If not specified, the first page of results will be returned.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the fetched first and
        #   third party audiences.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListFirstAndThirdPartyAudiencesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListFirstAndThirdPartyAudiencesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_first_and_third_party_audiences(advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/firstAndThirdPartyAudiences', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListFirstAndThirdPartyAudiencesResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListFirstAndThirdPartyAudiencesResponse
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a Floodlight group.
        # @param [Fixnum] floodlight_group_id
        #   Required. The ID of the Floodlight group to fetch.
        # @param [Fixnum] partner_id
        #   Required. The partner context by which the Floodlight group is being accessed.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::FloodlightGroup] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::FloodlightGroup]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_floodlight_group(floodlight_group_id, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/floodlightGroups/{+floodlightGroupId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::FloodlightGroup::Representation
          command.response_class = Google::Apis::DisplayvideoV1::FloodlightGroup
          command.params['floodlightGroupId'] = floodlight_group_id unless floodlight_group_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates an existing Floodlight group.
        # Returns the updated Floodlight group if successful.
        # @param [Fixnum] floodlight_group_id
        #   Output only. The unique ID of the Floodlight group. Assigned by the system.
        # @param [Google::Apis::DisplayvideoV1::FloodlightGroup] floodlight_group_object
        # @param [Fixnum] partner_id
        #   Required. The partner context by which the Floodlight group is being accessed.
        # @param [String] update_mask
        #   Required. The mask to control which fields to update.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::FloodlightGroup] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::FloodlightGroup]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_floodlight_group(floodlight_group_id, floodlight_group_object = nil, partner_id: nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1/floodlightGroups/{floodlightGroupId}', options)
          command.request_representation = Google::Apis::DisplayvideoV1::FloodlightGroup::Representation
          command.request_object = floodlight_group_object
          command.response_representation = Google::Apis::DisplayvideoV1::FloodlightGroup::Representation
          command.response_class = Google::Apis::DisplayvideoV1::FloodlightGroup
          command.params['floodlightGroupId'] = floodlight_group_id unless floodlight_group_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a Google audience.
        # @param [Fixnum] google_audience_id
        #   Required. The ID of the Google audience to fetch.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the fetched Google audience.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the fetched Google audience.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::GoogleAudience] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::GoogleAudience]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_google_audience(google_audience_id, advertiser_id: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/googleAudiences/{+googleAudienceId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::GoogleAudience::Representation
          command.response_class = Google::Apis::DisplayvideoV1::GoogleAudience
          command.params['googleAudienceId'] = google_audience_id unless google_audience_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists Google audiences.
        # The order is defined by the order_by
        # parameter.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the fetched Google audiences.
        # @param [String] filter
        #   Allows filtering by Google audience fields.
        #   Supported syntax:
        #   * Filter expressions for Google audiences currently can only contain at
        #   most one restriction.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `CONTAINS (:)`.
        #   * Supported fields:
        #   - `displayName`
        #   Examples:
        #   * All Google audiences for which the display name contains "Google":
        #   `displayName : "Google"`.
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `googleAudienceId` (default)
        #   * `displayName`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListGoogleAudiences` method.
        #   If not specified, the first page of results will be returned.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the fetched Google audiences.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListGoogleAudiencesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListGoogleAudiencesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_google_audiences(advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/googleAudiences', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListGoogleAudiencesResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListGoogleAudiencesResponse
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an inventory source group.
        # @param [Fixnum] inventory_source_group_id
        #   Required. The ID of the inventory source group to fetch.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the inventory source group.
        #   If an inventory source group is partner-owned, only advertisers to which
        #   the group is explicitly shared can access the group.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the inventory source group.
        #   A partner cannot access an advertiser-owned inventory source group.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::InventorySourceGroup] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::InventorySourceGroup]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_inventory_source_group(inventory_source_group_id, advertiser_id: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/inventorySourceGroups/{+inventorySourceGroupId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::InventorySourceGroup::Representation
          command.response_class = Google::Apis::DisplayvideoV1::InventorySourceGroup
          command.params['inventorySourceGroupId'] = inventory_source_group_id unless inventory_source_group_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists inventory source groups that are accessible to the current user.
        # The order is defined by the
        # order_by parameter.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the inventory source group.
        #   If an inventory source group is partner-owned, only advertisers to which
        #   the group is explicitly shared can access the group.
        # @param [String] filter
        #   Allows filtering by inventory source group properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by the logical operator `OR`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `inventorySourceGroupId`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `displayName` (default)
        #   * `inventorySourceGroupId`
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. For example,
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListInventorySources` method.
        #   If not specified, the first page of results will be returned.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the inventory source group.
        #   A partner cannot access advertiser-owned inventory source groups.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListInventorySourceGroupsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListInventorySourceGroupsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_inventory_source_groups(advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/inventorySourceGroups', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListInventorySourceGroupsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListInventorySourceGroupsResponse
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an inventory source.
        # @param [Fixnum] inventory_source_id
        #   Required. The ID of the inventory source to fetch.
        # @param [Fixnum] partner_id
        #   Required. The ID of the DV360 partner to which the fetched inventory source
        #   is permissioned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::InventorySource] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::InventorySource]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_inventory_source(inventory_source_id, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/inventorySources/{+inventorySourceId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::InventorySource::Representation
          command.response_class = Google::Apis::DisplayvideoV1::InventorySource
          command.params['inventorySourceId'] = inventory_source_id unless inventory_source_id.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists inventory sources that are accessible to the current user.
        # The order is defined by the
        # order_by parameter.
        # If a filter by
        # entity_status is not
        # specified, inventory sources with entity status `ENTITY_STATUS_ARCHIVED`
        # will not be included in the results.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that has access to the inventory source.
        # @param [String] filter
        #   Allows filtering by inventory source properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `AND` or `OR` logical operators. A
        #   sequence of restrictions implicitly uses `AND`.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `EQUALS (=)`.
        #   * Supported fields:
        #   - `status.entityStatus`
        #   - `commitment`
        #   - `deliveryMethod`
        #   - `rateDetails.rateType`
        #   - `exchange`
        #   Examples:
        #   * All active inventory sources:
        #   `status.entityStatus="ENTITY_STATUS_ACTIVE"`
        #   * Inventory sources belonging to Google Ad Manager or Rubicon exchanges:
        #   `exchange="EXCHANGE_GOOGLE_AD_MANAGER" OR exchange="EXCHANGE_RUBICON"`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `displayName` (default)
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name. For example,
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListInventorySources` method.
        #   If not specified, the first page of results will be returned.
        # @param [Fixnum] partner_id
        #   The ID of the partner that has access to the inventory source.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListInventorySourcesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListInventorySourcesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_inventory_sources(advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, partner_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/inventorySources', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListInventorySourcesResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListInventorySourcesResponse
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['partnerId'] = partner_id unless partner_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Downloads media. Download is supported on the URI `/download/`resource_name=**`
        # ?alt=media.`
        # **Note**: Download requests will not be successful without including `alt=
        # media` query string.
        # @param [String] resource_name
        #   Name of the media that is being downloaded.  See
        #   ReadRequest.resource_name.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [IO, String] download_dest
        #   IO stream or filename to receive content download
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::GoogleBytestreamMedia] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::GoogleBytestreamMedia]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def download_medium(resource_name, fields: nil, quota_user: nil, download_dest: nil, options: nil, &block)
          if download_dest.nil?
            command = make_simple_command(:get, 'download/{+resourceName}', options)
          else
            command = make_download_command(:get, 'download/{+resourceName}', options)
            command.download_dest = download_dest
          end
          command.response_representation = Google::Apis::DisplayvideoV1::GoogleBytestreamMedia::Representation
          command.response_class = Google::Apis::DisplayvideoV1::GoogleBytestreamMedia
          command.params['resourceName'] = resource_name unless resource_name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a channel for a partner or advertiser.
        # @param [Fixnum] partner_id
        #   The ID of the partner that owns the fetched channel.
        # @param [Fixnum] channel_id
        #   Required. The ID of the channel to fetch.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that owns the fetched channel.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Channel] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Channel]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_partner_channel(partner_id, channel_id, advertiser_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/partners/{+partnerId}/channels/{+channelId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Channel::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Channel
          command.params['partnerId'] = partner_id unless partner_id.nil?
          command.params['channelId'] = channel_id unless channel_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists channels for a partner or advertiser.
        # @param [Fixnum] partner_id
        #   The ID of the partner that owns the channels.
        # @param [Fixnum] advertiser_id
        #   The ID of the advertiser that owns the channels.
        # @param [String] filter
        #   Allows filtering by channel fields.
        #   Supported syntax:
        #   * Filter expressions for channel currently can only contain at most one
        #   * restriction.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be `CONTAINS (:)`.
        #   * Supported fields:
        #   - `displayName`
        #   Examples:
        #   * All channels for which the display name contains "google":
        #   `displayName : "google"`.
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `displayName` (default)
        #   * `channelId`
        #   The default sorting order is ascending. To specify descending order for a
        #   field, a suffix " desc" should be added to the field name. Example:
        #   `displayName desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token returned from the
        #   previous call to `ListChannels` method. If not specified, the first page
        #   of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListChannelsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListChannelsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_partner_channels(partner_id, advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/partners/{+partnerId}/channels', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListChannelsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListChannelsResponse
          command.params['partnerId'] = partner_id unless partner_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates an SDF Download Task. Returns an
        # Operation.
        # An SDF Download Task is a long-running, asynchronous operation. The
        # metadata type of this operation is
        # SdfDownloadTaskMetadata. If the request is successful, the
        # response type of the operation is
        # SdfDownloadTask. The response will not include the download files,
        # which must be retrieved with
        # media.download. The state of
        # operation can be retrieved with
        # sdfdownloadtask.operations.get.
        # Any errors can be found in the
        # error.message. Note
        # that error.details is expected to be
        # empty.
        # @param [Google::Apis::DisplayvideoV1::CreateSdfDownloadTaskRequest] create_sdf_download_task_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_sdfdownloadtask_sdf_download_task(create_sdf_download_task_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1/sdfdownloadtasks', options)
          command.request_representation = Google::Apis::DisplayvideoV1::CreateSdfDownloadTaskRequest::Representation
          command.request_object = create_sdf_download_task_request_object
          command.response_representation = Google::Apis::DisplayvideoV1::Operation::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Operation
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the latest state of an asynchronous SDF download task operation. Clients
        # should poll this method at intervals of 30 seconds.
        # @param [String] name
        #   The name of the operation resource.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_sdfdownloadtask_operation(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/{+name}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::Operation::Representation
          command.response_class = Google::Apis::DisplayvideoV1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets a single targeting option.
        # @param [String] targeting_type
        #   Required. The type of targeting option to retrieve.
        # @param [String] targeting_option_id
        #   Required. The ID of the of targeting option to retrieve.
        # @param [Fixnum] advertiser_id
        #   Required. The Advertiser this request is being made in the context of.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::TargetingOption] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::TargetingOption]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_targeting_type_targeting_option(targeting_type, targeting_option_id, advertiser_id: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/targetingTypes/{+targetingType}/targetingOptions/{+targetingOptionId}', options)
          command.response_representation = Google::Apis::DisplayvideoV1::TargetingOption::Representation
          command.response_class = Google::Apis::DisplayvideoV1::TargetingOption
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.params['targetingOptionId'] = targeting_option_id unless targeting_option_id.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists targeting options of a given type.
        # @param [String] targeting_type
        #   Required. The type of targeting option to be listed.
        # @param [Fixnum] advertiser_id
        #   Required. The Advertiser this request is being made in the context of.
        # @param [String] filter
        #   Allows filtering by targeting option properties.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `OR` logical operators.
        #   * A restriction has the form of ``field` `operator` `value``.
        #   * The operator must be "=" (equal sign).
        #   * Supported fields:
        #   - `targetingOptionId`
        #   The length of this field should be no more than 500 characters.
        # @param [String] order_by
        #   Field by which to sort the list.
        #   Acceptable values are:
        #   * `targetingOptionId` (default)
        #   The default sorting order is ascending. To specify descending order for
        #   a field, a suffix "desc" should be added to the field name.
        #   Example: `targetingOptionId desc`.
        # @param [Fixnum] page_size
        #   Requested page size. Must be between `1` and `100`. If unspecified will
        #   default to `100`. Returns error code `INVALID_ARGUMENT` if an invalid value
        #   is specified.
        # @param [String] page_token
        #   A token identifying a page of results the server should return.
        #   Typically, this is the value of
        #   next_page_token
        #   returned from the previous call to `ListTargetingOptions` method.
        #   If not specified, the first page of results will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DisplayvideoV1::ListTargetingOptionsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DisplayvideoV1::ListTargetingOptionsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_targeting_type_targeting_options(targeting_type, advertiser_id: nil, filter: nil, order_by: nil, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1/targetingTypes/{+targetingType}/targetingOptions', options)
          command.response_representation = Google::Apis::DisplayvideoV1::ListTargetingOptionsResponse::Representation
          command.response_class = Google::Apis::DisplayvideoV1::ListTargetingOptionsResponse
          command.params['targetingType'] = targeting_type unless targeting_type.nil?
          command.query['advertiserId'] = advertiser_id unless advertiser_id.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['orderBy'] = order_by unless order_by.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end

        protected

        def apply_command_defaults(command)
          command.query['key'] = key unless key.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
        end
      end
    end
  end
end
