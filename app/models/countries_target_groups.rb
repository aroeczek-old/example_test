class CountriesTargetGroups < ActiveRecord::Base
  belongs_to :country
  belongs_to :target_group

  validate :target_group, :root_validation

  private

  # if validation will be more complicated I would use custom validator or Dry::Validation
  def root_validation
    errors.add(:target_group_id, :not_root_object) unless target_group.is_root?
  end
end
