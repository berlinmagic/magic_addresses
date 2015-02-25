# MagicAddresses

An address gem for rails .. fetches *country*, *state*, *city*, *district* and *subdistrict* in seperated and translated models.

This gives the great advantage, that each address can be displayed in each language. And not matter how you write an address it fetches the right one.
For example the german city *munich* in german *München* .. both save a city-model with a name translated all app-locales. 

```ruby
rails g magic_addresses:install
```

- 1. **check the initialers** (*its important to first check the settings of the gem*)
- 2. **check the migration file**
- 3. **run `rake db:migrate`**
- 4. **add to your models**


#### Model methods

```ruby
  has_one_address     # => This model has one address associated with it. (ie: User)

  has_addresses       # => This model has many addresses. (ie: Company)

#   You can use `has_one_address` and `has_addresses` on the same model 
#   `has_one_address` sets the default flag so could be major address.

  has_nested_address  # => Has one directly nested addresses. (ie: User.street, User.city)

```

#### View Mehtods

```ruby
  
  <%= country_flag( :de, "small" ) %>
  # flag helper for all default countries ( "small" | "medium" | "large")
  
  <%= render "magic_addresses/addresses/fields/address", f: f %>
  # form helper for 'has_one_address'
  
```

#### in your Controllers:

```ruby
  
  private
  
    # Never trust parameters from the scary internet! ... has_one_address
    def instance_params
      params.require(:instance).permit( .. :address_attributes => [:id, :street, :number, :postalcode, :city, :country, :_destroy] .. )
    end
    
    
    # Never trust parameters from the scary internet! ... has_addresses
    def instance_params
      params.require(:instance).permit( .. :addresses_attributes => [:id, :street, :number, :postalcode, :city, :country, :_destroy] .. )
    end
  
  - or -
  
  :address_attributes => MagicAddresses::Address::PARAMS      # has_one_address
  :addresses_attributes => MagicAddresses::Address::PARAMS    # has_addresses
  
```



#### Structure

Address:
- street *(globalized)*
- street_additional
- number
- postalcode
- **country**
- - name *(globalized)*
- - iso_code
- - dial_code *(phone)*
- **state**
- - name *(globalized)*
- - short_name
- **city**
- - name *(globalized)*
- - short_name
- **district**
- - name *(globalized)*
- - short_name
- **subdistrict**
- - name *(globalized)*
- - short_name


#### Getter & Setter
```ruby
  :street
  :number
  :postalcode
  :city
  :district
  :subdistrict
  :state
  :country
```


.. will more info, sometimes ...


This project rocks and uses MIT-LICENSE.