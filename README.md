# SwiftUI Weather

This is an app I made in a weekend to learn more about using Combine and SwiftUI. I am pretty unfamiliar with Combine and haven't really used many reactive libraries before, so it was a little tough wrapping my head around how Combine works.

## Motivation

I've been messing around with SwiftUI ever since it was announced at WWDC19 but not much with Combine. I was kind of afraid of it because of the few times I tried using it, I could never really understand exactly what I was doing.

Now that I'm a bit more of a mature iOS developer (since I have been working professionally for a year in addition to the couple of years of unprofessional experience before that) I thought I would give Combine a shot again.

## Screenshots

<img src="./screenshots/screenshot1.png" alt="screenshot1" style="zoom: 25%;" /> <img src="/Users/alexfargo/Developer/iOS/Weather/Weather/screenshots/screencap1.gif" alt="screencap1" style="zoom: 47%;" />

## What I Learned

So the main goal of this project was to learn more about using Combine and SwiftUI together. Boy did I certainly learn a few things...

One of the biggest problems I ran into was searching for weather by named location.

See, the endpoint I chose to use in the Open Weather API has two main parameters `lat` latitude and `lon` longitude. Now, obviously it would be a horrible UX if I had the users type in their coordinates just to search for weather conditions at a location, so I did some searching for a way to convert a location string to some coordinates. Luckily, Apple provides such a feature in the CoreLocation API. Great 🙌. Except it is an asynchronous call (makes sense) that does not use Combine 😰. I already had code up and running for making a call to the Open Weather API endpoint with a `dataTaskPublisher` and some predetermined coordinates which wasn't too bad to setup. But now I had to figure how to link together these two calls.

Had I not been using Combine, I probably would have just used a Semaphore and used the result of the CoreLocation call in the Open Weather call. But no, we are using Combine!

So, I learned about this other Publisher type called a `Future` which is a little more familiar looking cause it is an asynchronous call with a completion (kind of). With a `Future`, you have a `Promise`, which in this case is a closure to be called in the *future* with a `Result` type parameter. This was super easy to understand and implement.

The hard part came when I had to link these two calls together. I knew I wanted the location call to occur first then the weather call, but how the heck do I do this in Combine?? I started doing lots of searching and basically discovered that `map` is my best friend. As long as I got the types to match at the beginning and end of each of the transformation methods, then everything should work out. Boy was it a pain figuring out the types on each end and how to get them to that point.

You will see in the code that there are lots of `.eraseToAnyPublisher()` calls. At a basic level, what this does is what it sounds like, it strips the publisher type from the publisher to its bare bones, the `Output` type and the `Failure` type, then wraps it in `AnyPublisher`. Then you have some `Publisher` that has X output type and Y failure type. As long as you match those in your next publisher transformation, then you are good 👍

Eventuall I got it to work and I was so relieved and happy. I really do feel like I understand Publishers and subscribers A LOT more now. Hopefully this all made sense... Feel free to email me if you want help or don't understand something I've said. Combine is super tricky and it won't make sense on your first try, but that's okay. Just keep trying and eventually it will click!

## Usage

To download and use this project, you must obtain an Open Weather API key from [here](https://openweathermap.org/api).

Once you have a key, navigate to the Support folder in the project and create a property list file named "Secrets.plist."

Create a key named `openWeatherAPIKey` and assign the key that you obtained to the value.

## Contribute

If you would like to contribute, please do!

## License

MIT (c) [Alex Fargo](https://github.com/flexaargo) [(x)](https://twitter.com/flexaargo)

