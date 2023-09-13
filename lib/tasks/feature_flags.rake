namespace :feature_flags do
  desc 'Add a new feature flag'
  task :add, [:name, :value] => :environment do |_, args|
    name = args[:name]
    value = args.key?(:value) ? ActiveRecord::Type::Boolean.new.cast(args[:value]) : false

    feature_flag = FeatureFlag.find_by(name: name)

    if feature_flag
      puts "Feature flag '#{name}' already exists and has value '#{feature_flag.value}."
    else
      FeatureFlag.create(name: name, value: value)
      puts "Feature flag '#{name}' added with a value of '#{value}'."
    end
  end

  desc 'Get the value of an existing feature flag'
  task :get, [:name] => :environment do |_, args|
    name = args[:name]

    feature_flag = FeatureFlag.find_by(name: name)

    if feature_flag
      puts "Feature flag '#{name}' value is '#{feature_flag.value}'."
    else
      puts "Feature flag '#{name}' not found."
    end
  end

  desc 'Set the value of an existing feature flag'
  task :set, [:name, :value] => :environment do |_, args|
    name = args[:name]
    value = ActiveRecord::Type::Boolean.new.cast(args[:value])

    feature_flag = FeatureFlag.find_by(name: name)

    if feature_flag && value
      feature_flag.update!(value: value)
      puts "Set feature flag '#{name}' to '#{feature_flag.value}'."
    elsif !feature_flag
      puts "Feature flag '#{name}' not found."
    elsif !value
      puts "Feature flag value is not given"
    end
  end
end
