# Pizzas Aggregation

## Insertion des commandes de pizzas dans la collection "orders"

```JS
db.orders.insertMany( [
   { _id: 0, name: "Pepperoni", size: "small", price: 19,
     quantity: 10, date: ISODate( "2021-03-13T08:14:30Z" ) },
   { _id: 1, name: "Pepperoni", size: "medium", price: 20,
     quantity: 20, date : ISODate( "2021-03-13T09:13:24Z" ) },
   { _id: 2, name: "Pepperoni", size: "large", price: 21,
     quantity: 30, date : ISODate( "2021-03-17T09:22:12Z" ) },
   { _id: 3, name: "Cheese", size: "small", price: 12,
     quantity: 15, date : ISODate( "2021-03-13T11:21:39.736Z" ) },
   { _id: 4, name: "Cheese", size: "medium", price: 13,
     quantity:50, date : ISODate( "2022-01-12T21:23:13.331Z" ) },
   { _id: 5, name: "Cheese", size: "large", price: 14,
     quantity: 10, date : ISODate( "2022-01-12T05:08:13Z" ) },
   { _id: 6, name: "Vegan", size: "small", price: 17,
     quantity: 10, date : ISODate( "2021-01-13T05:08:13Z" ) },
   { _id: 7, name: "Vegan", size: "medium", price: 18,
     quantity: 10, date : ISODate( "2021-01-13T05:10:13Z" ) }
] )
```

## Calcul de la quantité des pizzas commandées par taille et par type

```JS
db.orders.aggregate( [

   // Stage 1: Filter pizza order documents by pizza size
   {
      $match: { size: "medium" }
   },

   // Stage 2: Group remaining documents by pizza name and calculate total quantity
   {
      $group: { _id: "$name", totalQuantity: { $sum: "$quantity" } }
   }

] )
```

Résultats obtenus

```JS
[
  {
    _id: 'Pepperoni',
    totalQuantity: 20
  },
  {
    _id: 'Cheese',
    totalQuantity: 50
  },
  {
    _id: 'Vegan',
    totalQuantity: 10
  }
]
```

## Calcul la valeur totale de la commande et la quantité moyenne de la commande

```JS
db.orders.aggregate( [

   // Stage 1: Filter pizza order documents by date range
   {
      $match:
      {
         "date": { $gte: new ISODate( "2020-01-30" ), $lt: new ISODate( "2022-01-30" ) }
      }
   },

   // Stage 2: Group remaining documents by date and calculate results
   {
      $group:
      {
         _id: { $dateToString: { format: "%Y-%m-%d", date: "$date" } },
         totalOrderValue: { $sum: { $multiply: [ "$price", "$quantity" ] } },
         averageOrderQuantity: { $avg: "$quantity" }
      }
   },

   // Stage 3: Sort documents by totalOrderValue in descending order
   {
      $sort: { totalOrderValue: -1 }
   }

 ] )
```

Résultats obtenus

```JS
[
  {
          _id: '2022-01-12',
    totalOrderValue: 790,
    averageOrderQuantity: 30
  },
  {
      _id: '2021-03-13',
    totalOrderValue: 770,
    averageOrderQuantity: 15
  },
  {
      _id: '2021-03-17',
    totalOrderValue: 630,
    averageOrderQuantity: 30
  },
  {
      _id: '2021-01-13',
    totalOrderValue: 350,
    averageOrderQuantity: 10
  }
]
```

Crédit : <https://www.mongodb.com/docs/manual/core/aggregation-pipeline/>

--

!["Logotype Shrp"](https://shrp.dev/images/shrp.png)

__Alexandre Leroux__  
_Enseignant / Formateur_  
_Développeur logiciel web & mobile_

Nancy (Grand Est, France)

<https://shrp.dev>
