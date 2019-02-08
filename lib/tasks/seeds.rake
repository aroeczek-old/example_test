namespace :seeds do
  desc 'Seed for panel providers'
  task panel_providers: :environment do
    prevent_production!

    PanelProvider::TYPES.each.with_index(1) do |type, index|
      type.constantize.create!(code: "panel_#{index}")
    end

    Rails.logger.info('Seeding providers done')
  end

  desc 'Seed for countries'
  task countries: [:environment, 'seeds:panel_providers'] do
    prevent_production!

    panel_ids = PanelProvider.ids

    (1..3).each { |number| Country.create!(code: "c_#{number}", panel_provider_id: panel_ids.sample) }

    Rails.logger.info('Seeding countries done')
  end

  desc 'Seed for locations'
  task locations: :environment do
    prevent_production!

    (1..20).each { |number| Location.create!(name: "l_#{number}",
                                             external_id: SecureRandom.uuid,
                                             code: "secret_#{number}") }

    Rails.logger.info('Seeding locations done')
  end

  desc 'Seed for location groups'
  task location_groups: [:environment, 'seeds:panel_providers', 'seeds:countries'] do
    prevent_production!

    panel_ids    = PanelProvider.ids
    country_ids  = Country.ids
    location_ids = Location.ids

    (1..4).each { |number| LocationGroup.create!(name: "lg_#{number}",
                                                 country_id: country_ids.sample,
                                                 location_id: location_ids.sample,
                                                 panel_provider_id: panel_ids.shift || PanelProvider.first.id )}

    Rails.logger.info('Seeding location groups done')
  end

  desc 'Seed for target groups'
  task target_groups: [:environment, 'seeds:panel_providers'] do
    prevent_production!

    panel_ids = PanelProvider.ids

    (1..4).each do |number|
      root = TargetGroup.create!(name: "root_#{number}",
                                 external_id: SecureRandom.uuid,
                                 panel_provider_id: panel_ids.shift || PanelProvider.first.id,
                                 code: "secret_#{number}")
      (1..3).each do |number|
        TargetGroup.create!(name: "child_#{number}_for_#{root.id}",
                            external_id: SecureRandom.uuid,
                            parent: root,
                            panel_provider_id: root.panel_provider_id,
                            code: "secret_#{number}")
      end
    end

    Rails.logger.info('Seeding target groups done')
  end

  desc 'Seeds whole data set'
  task data: :environment do
    prevent_production!
    Rails.logger.info('Seeding data...')

    %w(panel_providers countries locations location_groups target_groups).each { |task| Rake::Task["seeds:#{task}"].execute }

    Rails.logger.info('Seeding data done')
  end
end

private

def prevent_production!
  raise 'You cannot run this in production' if Rails.env.production?
end
