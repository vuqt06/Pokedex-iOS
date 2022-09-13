# Pokedex-iOS

Preview of the app:

https://user-images.githubusercontent.com/86247337/189796871-d1a9b72c-2820-4218-9d6f-94490d8da5de.mp4


Milestone 1:
- I used 3 structs to store different types of data fetched from PokéAPI:
  + The PokemonList struct presents the response from each API call with offset and limit queries.
  + The PokemonLink struct presents each object in results list of PokemonList.
  + The Pokemon struct presents the data of each pokemon.

- In addition, I created an evironment object called PokemonModel to access it in all views of the app:
  + It has pokemonImages property holding fetched images.
  + It nextUrlLink property holding the next URL that we need to fetch.
  + It has fetchData method which has 2 parameters url and type presenting the url that we fetch the data from and the type of the data. We have 2 types of data: pokemonList for a list of pokemons and pokemonData for the single pokemon.
  
 - I utilized the LazyVGrid to display the pokemons in grid layout.
 - I also used a variable to keep track which pokemon the user taps on to display it in the large card.
 
 Milestone 2:
 - I used a counter variable called countPokemon to keep track the number of pokemons first appear. When (countPokemon % 20 == 0) means that the last pokemon of each API call has appeared, we will call another API to fetch the next 20 pokemons if the url exists.
 
 Milestone 3:
 - I created a class called CacheService which has imageCache property, which is a dictionary whose keys are URLs of pokemon images and values are the images themselves.
 - CacheService has 2 methods: getImage() to retrieve the images if they have been already fetched and setImage() to store the new images into the cache.
 
 Styling:
 - I added some styling using ZStack and basic shapes to make the pokemons look like pokemon cards.
 - I used ScrollViewReader to detect when the user taps on a pokemon, it will automatically scroll to the top, where the large pokemon card display.
