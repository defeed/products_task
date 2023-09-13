class FeatureFlagsService
  # Acceptable fallback values:
  # true | false
  # 'true' | 'false'
  # 't' | 'f'
  # 1 | 0
  def self.is_enabled?(feature_flag_name, fallback_value = false)
    feature_flag = FeatureFlag.find_by(name: feature_flag_name)

    if feature_flag
      feature_flag.value
    else
      ActiveRecord::Type::Boolean.new.cast(fallback_value)
    end
  end
end
