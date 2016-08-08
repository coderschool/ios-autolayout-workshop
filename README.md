## iOS Saigon #2: Auto Layout Workshop

**What we will build:**

![](http://i.imgur.com/HKbQoBU.png)

In this exercise we will build an app that display popular GitHub repositories by language. We will practice using Auto Layout with table views.

## What is Auto Layout?

Until the introduction of iPad and iPhone 5, all screens in the iOS world had the same [point](https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html#//apple_ref/doc/uid/TP40010156-CH14-SW7) dimensions of 320x480 width x height. At this point in time it was often possible to describe an app's layout by specifying the absolute position and size of views.

Auto Layoutprovides a convenient way for you to describe how the size and position of your [views](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html) should change when the size and position their parent views or neighboring views change.

* Run on different devices
* Size or number of neighboring views change due to the change in content
* Rotating the device

![](http://i.imgur.com/ZAuzNug.png)

![](http://i.imgur.com/0WwqszZ.png)

### Before you start:

Let's walk through the steps together. You can skip to a specific milestone by typing `git checkout milestoneN`. If you have changes before switching, make sure to commit or stash your changes first.

### Milestone 1: Setup

1. Clone the project from Github:

  ```bash
  git clone https://github.com/coderschool/ios-autolayout-workshop
  ```

2. Open the `GithubDemo.xcworkspace` file and run the app.
3. You should see a list of GitHub repositories and their details printed in the console:
    ![Imgur](https://i.imgur.com/PJd7VOd.png)

Note: The unauthenticated Github search API is rate-limited at 10 requests per
minute.  If you run into rate-limiting issues, you can [register an app](https://github.com/settings/developers) and put your `clientId` and `clientSecret` in the `GithubRepo` class.

### Milestone 2: Augment the GithubRepo Model to include the Repo Description
1. Add a `repoDescription` field to the `GithubRepo` model to represent a repository's description.
2. Set the `repoDescription` field for each repository based on the data from the call to the [Github Search
  API](https://developer.github.com/v3/search/#search-repositories).
3. Verify that you parsed the description correctly by adding it to the `GithubRepo`'s `description` method:

    ![Imgur](https://i.imgur.com/HTj3xBw.png)

### Milestone 3a: Create the Main Repo Table View

![GitHub|250](http://i.imgur.com/HKbQoBU.png)

1. In the `doSearch()` method of `RepoResultsViewController`, in addition to printing out the `newRepos`, store the returned repos in a property (`var repos: [GithubRepo]!`).
2. Add a [table view](https://guides.codepath.com/ios/Table-View-Quickstart) to the main `RepoResultsViewController` to display your search results.
  - The rows in your table should be [automatically resizing](https://guides.codepath.com/ios/Table-View-Guide#automatically-resizing-rows-ios-8) based on the contents of each cell.
  - Make sure to call `reloadData` on your tableView after the network request comes back - i.e. in the `successCallback` of `fetchRepos(...)`.

### Milestone 3b: Design the Repo Row

Design a custom cell to contain all the information associated with a repository.

- The cell should display the name, owner, stars, forks, and description as well as the owner's avatar.
    - Icons for "fork" and "star" are included in the starter project.
    - `AFNetworking+UIImageView` has already been integrated into the starter project.  You should use this to display the avatar image.
- The cell's contents should be laid out using [Auto Layout](https://guides.codepath.com/ios/Auto-Layout-Basics).
- The repository name and description labels should wrap if the text does not fit on one line:
    - You can make a label multiline by setting the `lines` count to 0 in the inspector.
    - To get the text to wrap properly for multiline labels with dynamic content you'll need to set the `preferredMaxLayoutWidth`. Fortunately, for apps targeting iOS8+, there is a simple setting in Interface Builder on the Label to do this automatically for you. Make sure that `Preferred Width` is set to `Automatic`:
          ![Imgur](http://i.imgur.com/rp7cA6V.png)
    - If you have a multiline label adjacent to single-line labels you may need to adjust the [compression resistance](http://guides.codepath.com/ios/Auto-Layout-Basics#compression-resistance) of your single-line labels in order to force the multiline label to wrap properly.

# Bonus

You can do the following tasks at home if interested. Email me at harley@coderschool.vn if you have questions.

The final results should look like this: ![](http://i.imgur.com/jYMsqdt.gif)

### Bonus 4: Allow Filtering by Number of Stars

![Github|250](http://i.imgur.com/HEqgPrO.png)

1. Add a settings button to the left of the search bar.
  - For buttons in the navigation bar, you should use a `BarButtonItem` in Interface Builder.

2. Tapping on the settings button should [modally](https://guides.codepath.com/ios/Using-Modal-Transitions) present a settings view controller.
  - You can quickly [add a navigation bar](https://guides.codepath.com/ios/Navigation-Controller-Quickstart#storyboard-setup) to your settings view controller by embedding it inside a navigation controller via the `Editor -> Embed In -> Navigation Controller` menu option. Method 2: just add a navigation bar directly to the view (instead of using a navigation controller).
    - Double click on the navigation bar to set your view controller title.
  - You'll need a way to pass the settings information between the main view controller and your settings view controller.  If you're using storyboards this can be done in `prepareForSegue` and by setting up an unwind segue, as in
[this guide](https://guides.codepath.com/ios/Navigation-Controller#unwind-segues-and-passing-information-back-up-the-hierarchy). Note:
    - You can also use the delegate pattern (with a little more code).
    - Make sure your unwind segue method is in the same view controller with `prepareForSegue` (and make sure it has the correct function argument).

3. The settings view controller should have a single setting for the minimum number of stars a repo needs to have.
    - This should be represented by a slider.

4. There is a save button for settings.  When the save button is tapped the settings are saved and applied to the search immediately.

5. There is a cancel button.  Tapping on the cancel button returns to the main search results and *discards any changes to the settings* so that they are not reflected once the settings screen is opened the next time.
  - In order to discard any changes when the cancel button is tapped, you'll have to store a copy of the settings information in the settings view controller.
  - In Swift a quick way to make it easy to copy basic data objects (including arrays and maps) is by embedding them inside a struct.  For example, changing the `GithubRepoSearchSettings` class to a struct makes it so that any assignment (via the = operator) creates a copy instead of a pointer to the object.

### Bonus 5: Allow Filtering by Language

1. The settings view controller should use a [table view to display all settings](http://guides.codepath.com/ios/Form-Input#example-basic-preferences-page-revisited).
2. There should be a setting for whether to filter by language.  This setting is controlled by a toggle switch.
3. When the language filter toggle is on, a list of languages should appear in the table.
4. Tapping on a language toggles whether it will be included in the search.

### More Bonus Features
If you managed to finish all the milestones here are few things you can try:
- Add options for whether the search should match text in a repo's name,
  description, and/or README.
- Add options for sorting search results based on [stars, forks, or relevance](https://developer.github.com/v3/search/#search-repositories)
- Add options for searching only repositories created after a certain date (e.g.
  within the past week, month, year).
- All languages available on github are defined [here](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml). Design and implement an interface for filtering based on that list of languages.
