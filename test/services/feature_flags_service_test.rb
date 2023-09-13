require 'test_helper'

class FeatureFlagsServiceTest < ActiveSupport::TestCase
  test 'is_enabled? should return true when feature flag is enabled' do
    feature_flag = FeatureFlag.create(name: 'my_feature_flag', value: true)
    assert_equal true, FeatureFlagsService.is_enabled?('my_feature_flag')
  end

  test 'is_enabled? should return false when feature flag is disabled' do
    feature_flag = FeatureFlag.create(name: 'my_feature_flag', value: false)
    assert_equal false, FeatureFlagsService.is_enabled?('my_feature_flag')
  end

  test 'is_enabled? should return fallback value when feature flag does not exist' do
    assert_equal true, FeatureFlagsService.is_enabled?('non_existent_flag', true)
    assert_equal false, FeatureFlagsService.is_enabled?('non_existent_flag', false)
  end
end
