# ARLocalizerView iOS

Welcome to the ARLocalizerView for iOS project. It's an application made for displaying chosen locations distances on a camera preview.

## Team

* [Sandra Jaworska](mailto:sandra.jaworska@netguru.com) - Project Manager
* [Jędrzej Gronek](mailto:jedrzej.gronek@netguru.com) - Developer

## Tools & Services

* Tools:
	* Xcode 11.2 with latest iOS SDK (13.1)
	* [Carthage](https://github.com/Carthage/Carthage) 0.33 or higher
* Services:
	* [JIRA](https://netguru.atlassian.net/secure/RapidBoard.jspa?rapidView=1254&view=detail)
	* [Bitrise](https://www.bitrise.io/app/9fcaffccbcfb2fd8#)

## Configuration

### Prerequisites

- [Homebrew](https://brew.sh)
- [Carthage](https://github.com/Carthage/Carthage) (`brew install carthage`)

### Instalation

1. Clone repository:

	```bash
	# over https:
	git clone https://github.com/netguru/ar-localizer-view-ios.git
	# or over SSH:
	git clone git@github.com:/netguru/ar-localizer-view-ios.git
	```

2. Run Carthage:

	```bash
	carthage bootstrap --platform iOS --cache-builds
	```

3. Open `ARLocalizerView.xcodeproj` file and build the project.


## Coding guidelines

- Respect Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- The code must be readable and self-explanatory - full variable names, meaningful methods, etc.
- Don't leave any commented-out code.
- Write documentation for every method and property accessible outside the class. For example well documented method looks as follows:

	for **Swift**:

	```swift
	/// Tells the magician to perform a given trick.
	///
	/// - Parameter trick: The magic trick to perform.
	/// - Returns: Whether the magician succeeded in performing the magic trick.
	func perform(magicTrick trick: MagicTrick) -> Bool {
		// body
	}
	```

## Related repositories

- [ar-localizer-view-android](https://github.com/netguru/ar-localizer-view-android)
