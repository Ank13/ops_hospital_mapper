# ho$pitally

Hospitals charge drastically different amounts for the same procedure. In order to make this data accessible to the public and promote a discussion of the burgeoning cost of healthcare in the US, we've combined the recently released Medicare chargemaster data with government measures of quality, such as patient survey results and outcomes of care, geocoded all addresses, and mapped on Google Maps.

Live demo: [http://hospital-mapper.herokuapp.com](http://hospital-mapper.herokuapp.com)

### Team

- [Avi Kaufman](https://github.com/Ank13)
- [Rod Levy](https://github.com/rodlevy)
- [Anna-Marie Panlilio](https://github.com/codesliced)
- [Daniel Song](https://github.com/danielx328)


### Setting up your development environment

1. Fork and then clone to your computer

2. Install all gems:
```
    $ bundle install
```

3. Setup the database:
```
    $ rake db:create && rake db:migrate
```

4. Load CSV files into your local database. You should have 3337 hospitals and over 163,000 hospital_procedures:
```
    $ rake import:all
```

5. Optional: Use the Figaro gem to set your Google Maps API key. (The app should run on your local machine without this step):
```
$ rails generate figaro:install
```
Edit your config/application.yaml file and add your google maps api key as GOOGLE_API_DEV.
