# MarvelApp

He usado el patrón MVVM.

He utilitzado una vista para acceder a la lista de los personajes porque no quiero que el usuario se quede bloqueado mientras se descargan los datos de la red. Además, sería un buen sitio para añadir "Ver cómics", "Ver series"...

Lo que implica a los pods:
- SwiftLint: Para la correcta implementación
- Alamofire: Para obtener la información de la web
- CryptoSwift: Para el md5() necesario para hacer la llamada
- SDWebImage: Para la carga de las imágenes

Me he dado cuenta al hacer la llamada del detalle que dentro del primer listado ya tengo el detalle de todos los personajes, por tanto, veo innecesario hacer la segunda llamada. Pero como comentamos en el correo, he hecho igualmente la implementación del detalle haciendo la llamada.
