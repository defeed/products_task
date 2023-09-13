require "test_helper"

class FeatureFlagTest < ActiveSupport::TestCase
  def setup
    @flag = FeatureFlag.new(name: 'example_flag')
  end

  test 'should be valid' do
    assert @flag.valid?
  end

  test 'name should be present' do
    @flag.name = ''
    assert_not @flag.valid?
  end

  test 'name should be unique (case insensitive)' do
    duplicate_flag = @flag.dup
    duplicate_flag.name = @flag.name.upcase
    @flag.save
    assert_not duplicate_flag.valid?
  end
end
