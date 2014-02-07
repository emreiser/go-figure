
# Seed with category of HDI
command_over_resources = Category.create(name: 'Command Over Resources', url_end: 'ti85-2nvi')
innovation_technologoy = Category.create(name: 'Innovation and Technology', url_end: 'jixu-gnyy')
environment = Category.create(name: 'Environment', url_end: 'ki8j-r4i6')
education = Category.create(name: 'Education', url_end: 'mvtz-nsye')
health = Category.create(name: 'Health', url_end: 'iv8b-7gbj')
population = Category.create(name: 'Population', url_end: 'e6xu-b22v')
gender_inequality = Category.create(name: 'Gender Inequality Index', url_end: 'pq34-nwq7')

# Seed all countries
entries = JSON.parse(HTTParty.get('http://data.undp.org/resource/9jnv-7hyp.json').body)
entries.each do |entry|
	if entry['type'] == 'Ranked Country'
		Country.create(name: entry['name'], code: entry['country_code'], hdi_rank: entry['_2012_hdi_rank'])
	end
end

# Change name of South Korea & Venezuela
korea = Country.find_by(name: 'Korea (Republic of)')
korea.name = 'South Korea'
korea.save!

venezuela = Country.find_by(name: 'Venezuela (Bolivarian Republic of)')
venezuela.name = 'Venezuela'
venezuela.save

russia = Country.find_by(name: 'Russian Federation')
russia.name = 'Russia'
russia.save

# Set selected countries
selected_countries = [
	'United States',
	'Cuba',
	'Rwanda',
	'South Korea',
	'Saudi Arabia',
	'Mexico',
	'Venezuela',
	'United Arab Emirates',
	'China',
	'Brazil',
	'Kenya',
	'Russia',
	'India'
]

selected_countries.each do |name|
	country = Country.find_by(name: name)
	country.select = true
	country.save
end

#  Seed select criteria in criteria table
# Command over resources
Criterion.create(category: command_over_resources, name: '_2010_health_of_gdp', display_name: 'percent of GDP spent on health in 2010', higher_good: true)
Criterion.create(category: command_over_resources, name: '_2010_military_of_gdp', display_name: 'percent of GDP spent on military in 2010', higher_good: false)
Criterion.create(category: command_over_resources, name: '_2005_2010_education_of_gdp', display_name: 'percent of GDP spent on education in 2010', higher_good: true)
# Innovation & tech
Criterion.create(category: innovation_technologoy, name: '_2010_fixed_and_mobile_telephone_subscribers', display_name: 'ratio of telephone subscribers in 2010', higher_good: true)
Criterion.create(category: innovation_technologoy, name: '_2005_2010_research_and_development_expenditure', display_name: "research and development expenditure in 2005\-2010", higher_good: true)
Criterion.create(category: innovation_technologoy, name: '_2002_2011_graduates_in_science_and_engineering', display_name: "percent of graduates in science and engineering in 2002\-2011", higher_good: true)
Criterion.create(category: innovation_technologoy, name: '_2010_internet_users', display_name: 'ratio of internet users in 2010', higher_good: true)
# Environment
Criterion.create(category: environment, name: '_2009_renewable_energy_usage', display_name: 'renewable energy usage 2009', higher_good: true)
# Criterion.create(category: environment, name: '_2009_agricultural_land', display_name: 'percent of agricultural land in 2009', higher_good: true)
Criterion.create(category: environment, name: '_2008_carbon_dioxide_emissions', display_name: 'carbon dioxide emissions in 2008', higher_good: false)
# Education
Criterion.create(category: education, name: '_2002_2011_gross_enrollement_ratio_secondary', display_name: "percent enrollment in secondary school in 2002\-2011", higher_good: true)
Criterion.create(category: education, name: '_2002_2011_gross_enrollement_ratio_tertiary', display_name: 'percent enrollment in college in 2002-2011', higher_good: true)
# Health
Criterion.create(category: health, name: '_2007_2009_satisfaction_with_health_care_quality', display_name: "satisfaction with health care quality in 2007\-2009", higher_good: true)
# Population
# Criterion.create(category: population, name: '_2012_urban_population', display_name: 'percent of population in urban areas in 2012')
Criterion.create(category: population, name: '_2000_2005_annual_population_growth', display_name: "annual population growth in 2000\-2005", higher_good: false)
# Gender Inequality
Criterion.create(category: gender_inequality, name: '_2012_seats_in_national_parliament_female', display_name: 'percentage of seats in parliament held by women in 2012', higher_good: true)
Criterion.create(category: gender_inequality, name: 'adolescent_fertility_rate', display_name: 'teen pregnancy rate', higher_good: false)
Criterion.create(category: gender_inequality, name: '_2012_gender_inequality_index_rank', display_name: 'gender inequality', higher_good: false)
Criterion.create(category: gender_inequality, name: '_2006_2010_population_with_at_least_secondary_education_female', display_name: "percent of female population with at least secondary education in 2006\-2010", higher_good: true)

# Seed scores table
Category.all.each do |category|
	collection = JSON.parse(HTTParty.get('http://data.undp.org/resource/# {category.url_end}.json').body)

	collection.each do |entry|
		if entry['type'] == 'Ranked Country'
			criteria = Criterion.where(category_id: category.id)
			criteria.each do |criterion|
				country = Country.find_by(code: entry['country_code'])
				if country.present?
					Score.create(country_id: country.id, criterion_id: criterion.id, score: entry[criterion.name])
				end
			end
		end
	end
end
