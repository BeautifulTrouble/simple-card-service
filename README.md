# Simple Card Service

> For embedding 'cards' using OpenGraph or Twitter card meta data

## Intention

A very, very simple service to send back just enough data to represent a resource as 'card' on another site.

## Prior art

* https://iframely.com/docs/promo-cards
* http://embed.ly/cards

These are both fancy, possibly not-free, and complicated options.

The prevailing pattern seems to be providing a <code>`<blockquote>`</code> element with data attributes, as well as a JavaScript payload that then appends an iFrame to the document with the necessary markup and styling for displaying the card with the data provided by a service.
