export class AddArticleDto {
    name: string;
    categoryId: number;
    shortDescription: string;
    description: string;
    price: number;
    manufacturerId: number;
    materialId: number;

    features: {
        featureId: number;
        value: string;
    }[];
}


/* Primer koji smo koristili u postman-u
{
    "name": "Plava ogrlica",
    "categoryId": 1,
    "shortDescription" : "Kratak opis",
    "description: "Deteljan opis",
    "price": 200,

    "features": [

        { "featureId": 1, "value": "Zelena" },
        { "featureId": 4, "value": "12cm" }

    ]
}
*/