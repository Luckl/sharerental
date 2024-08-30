# ShareRental

[ShareRental](www.sharerental.nl) is a rental platform for tools and machinery.

## Domain

| Entity      | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| User        | A user of the platform.                                                     |
| Lessor      | An entity that rents out their equipment. Can be managed by 1 or more users |
| RentalItem  | A product rented out by a lessor                                            |
| Transaction | The renting out of an item to a user by a lessor.                           |

### Transaction state

A state diagram describing the status of a transaction.

![Transaction state](https://www.plantuml.com/plantuml/png/VP11QmCX48Nl-olcNCWVy50YPW_29jd3zj9IYd6dD5JNHST3_dsrH8bDoUqnxtsFcTa6KfwYDTtRqpjiDiyW3tAIV92l_QwxqS10U5I4Cvmku74Xz8sVq97BtT-Pu0VH3qCgoow3KPr_6-WBIqisSfGBqO_JDTconMB0jSQLi7OO3C7v6cYngXW8jMWqvWvy42dx_HkP8m8veBD55mbE-EaymgekDa7jEiVzEFJvhgeOx9N_JYqgW7PsDNXtKGtNptuSNwQkYEiZoTqYMrpcQCqF)
[Edit image here](https://www.plantuml.com/plantuml/uml/TP11QmCX48Nl-olcNCWVy50YPW_29jd3zj9IYd6dD5JNHST3_dsrH8a9kJryttlEp3QGyXIjwJvUFc6pUGLva9FaWtplTzsD1WR2eoASuNG1ZmkXR_mK7RdStRy9VX3zCAIox38OrVc_WNwmj6GZero8VfokP9ij5WEkDQw4jSDW2CvNe8rLnK2eHQCn3y6dI9dl2J971790Puik4fpmstc4LLri2hNZ7FVZqEUzgcAmL_utjQW0sjdL83t-Mk1osQ_ZszGLSJqakTjTjhZCqPe_)

## Mollie integration

[Mollie hosted checkout example](https://demo.mollie.com/en/one-off-payments/?name=ShareRental&methods=IDCCPPBTBCGIPRKBBPPS)

[Mollie documentation](https://docs.mollie.com/payments/accepting-payments)

## Zip Code DB

Retrieved from https://public.opendatasoft.com/explore/dataset/georef-netherlands-postcode-pc4/export/

# Development

### Ngrok for webhook callbacks from mollie (localhost)

Token can be retrieved by creating an account on [ngrok.com](https://dashboard.ngrok.com/)

in `application.yaml` update the key `ngrok.token` with the token from ngrok

when starting the application, a tunnel will be created to your localhost on port 8080

The ngrok plugin will log the forwarding url to the console. Copy it and use it as the webhook url in the mollie configuration in `application.yaml` under `sharerental.webhookUrl`

Restart the application, and you should be able to receive webhook callbacks from mollie