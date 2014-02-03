
# Seed with category of HDI
command_over_resources = Category.create(name: 'Command Over Resources', url_end: 'ti85-2nvi')
innovation_technologoy = Category.create(name: 'Innovation and Technology', url_end: 'jixu-gnyy')
environment = Category.create(name: 'Environment', url_end: 'ki8j-r4i6')
capital_flows = Category.create(name: 'International Capital Flows and Migrations', url_end: '3esk-n839')
trade_flows = Category.create(name: 'International Trade Flows of Goods and Services', url_end: 'itri-v7qr')
education = Category.create(name: 'Education', url_end: 'mvtz-nsye')
health = Category.create(name: 'Health', url_end: '')
social_integration = Category.create(name: 'Social Integration', url_end: 'n9mf-gwye.json')
population = Category.create(name: 'Population', url_end: 'e6xu-b22v')
gender_inequality = Category.create(name: 'Gender Inequality Index', url_end: 'pq34-nwq7')
poverty = Category.create(name: 'Multidimensional Poverty Index', url_end: '7p2z-5b33')

# Seed countries table with select Countries list
Country.create(name: 'United States', select: true)
Country.create(name: 'Cuba', select: true)
Country.create(name: 'Rwanda', select: true)
Country.create(name: 'Korea', select: true)
Country.create(name: 'Saudi Arabia', select: true)
Country.create(name: 'Mexico', select: true)
Country.create(name: 'Venezuela', select: true)
Country.create(name: 'United Arab Emirates', select: true)
Country.create(name: 'China', select: true)
Country.create(name: 'Brazil', select: true)
Country.create(name: 'Kenya', select: true)

# Seed select criteria in criteria table
#Command over resources
Criterion.create(category: command_over_resources, name: '_2010_health_of_gdp' )
Criterion.create(category: command_over_resources, name: '_2010_military_of_gdp' )
Criterion.create(category: command_over_resources, name: '_2005_2010_education_of_gdp' )
#Innovation & tech
Criterion.create(category: innovation_technologoy, name: '_2010_fixed_and_mobile_telephone_subscribers')
Criterion.create(category: innovation_technologoy, name: '_2005_2010_research_and_development_expenditure')
Criterion.create(category: innovation_technologoy, name: '_2002_2011_graduates_in_science_and_engineering')
Criterion.create(category: innovation_technologoy, name: '_2010_internet_users')
#Environment
Criterion.create(category: environment, name: '_2009_renewable_energy_usage')
Criterion.create(category: environment, name: '_2009_agricultural_land')
Criterion.create(category: environment, name: '_2008_carbon_dioxide_emissions')
#International Capital Flows and Migrations
Criterion.create(category: capital_flows, name: '_2010_international_inbound_tourism')
Criterion.create(category: capital_flows, name: '_2010_net_official_development_assistance_received')
Criterion.create(category: capital_flows, name: '_2010_inflow_remittances')
#International Trade Flows of Goods and Services
Criterion.create(category: trade_flows, name: '_2010_imports_of_merchandise_goods_billions')
Criterion.create(category: trade_flows, name: '_2010_exports_of_merchandise_goods_billions')
Criterion.create(category: trade_flows, name: '_2010_agricultural_share_of_imports')
#Education
Criterion.create(category: education, name: '_2002_2011_gross_enrollement_ratio_secondary')
Criterion.create(category: education, name: '_2002_2011_gross_enrollement_ratio_tertiary')

#Health !!!!!!!!!!!!!

#Social Integration
Criterion.create(category: social_integration, name: '_2007_2011_overall_life_satisfaction')
Criterion.create(category: social_integration, name: '_2005_2011_youth_unemployment')
#Population
Criterion.create(category: population, name: '_2012_urban_population')
Criterion.create(category: population, name: '_2000_2005_annual_population_growth')
#Gender Inequality
Criterion.create(category: gender_inequality, name: '_2012_seats_in_national_parliament_female' )
Criterion.create(category: gender_inequality, name: '_2010_maternal_mortality_ratio')
Criterion.create(category: gender_inequality, name: 'adolescent_fertility_rate')
Criterion.create(category: gender_inequality, name: '_2012_gender_inequality_index_rank')
Criterion.create(category: gender_inequality, name: '_2011_labour_force_participation_rate_female')
Criterion.create(category: gender_inequality, name: '_2006_2010_population_with_at_least_secondary_education_female')
#Poverty
Criterion.create(category: poverty, name: 'population_in_multidimensional_poverty' )
Criterion.create(category: poverty, name: '_2002_2011_population_below_income_poverty_line_national_poverty_line' )

# Seed scores table
# Category.all.each do |category|
# 	array = JSON.parse(HTTParty.get("http://data.undp.org/resource/#{category.url_end}.json").body)
# end