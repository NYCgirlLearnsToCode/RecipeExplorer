# RecipeExplorer

### Summary: Include screen shots or a video of your app highlighting its features

**Initial App UI**

<img src="https://github.com/user-attachments/assets/62d08045-7341-47f5-8873-f94fb6a9186b" alt="Simulator Screenshot" width="300"> <br/>


**Detail View, tap on video source**

<img src="https://github.com/user-attachments/assets/4353bd67-b752-4e20-8eef-7d4a6c3b04ba" alt="Simulator Screenshot" width="300">
<img src="https://github.com/user-attachments/assets/a441bb25-a2f6-4e86-b327-f7678129d6a1" alt="Simulator Screenshot" width="300"> <br/>

**Detail View, tap on recipe source**

<img src="https://github.com/user-attachments/assets/9521c63f-2a87-4cc1-b16c-345cb291abb3" alt="Simulator Screenshot" width="300">
<img src="https://github.com/user-attachments/assets/56d8a5e9-70c7-4d45-82e4-74aee789961c" alt="Simulator Screenshot" width="300"> <br/>

**Search/filter, Empty State**


<img src="https://github.com/user-attachments/assets/2743e2fb-d856-47e6-bedd-d4f04917b0f4" alt="Simulator Screenshot" width="300">
<img src="https://github.com/user-attachments/assets/cae52c95-4ff1-4a10-b414-82618f98fda9" alt="Simulator Screenshot" width="300">


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I chose to focus on UX, performance and data handling as well as code quality

1. User Experience (UX)
I aimed for a smooth and responsive UI using SwiftUI’s layout system. The interface is simple, clean, and gives clear feedback for loading data, showing errors, or handling empty states.

2. Performance & Data Handling
To keep things performant, I implemented efficient data loading with in-memory caching and async image loading. This ensures smooth scrolling and reduced network usage.

3. Code Quality
I stuck to Swift best practices — clean naming, using Codable for parsing, and a clear separation of concerns across Views, ViewModels, and Services for maintainability.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
 I spent roughly 7 hours working on this project.
 
 UI/UX Design: 2 hours — layout, navigation, and handling empty/error states

 Networking & Data Layer: 2 hours — API integration, caching, and error handling

 Testing & Debugging: 1–2 hours — manual testing and fixing edge cases

Polish & Documentation: 1 hour — cleanup, screenshots, and README

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
Caching: I kept things simple with in-memory caching (recipes + images). It improves performance but doesn’t persist data between launches.

Error Handling: Basic error messages are shown for now. More detailed handling (like distinguishing between network and decoding errors) could be added.

Feature Scope: I focused on core functionality — listing, detail view, search, and empty/error states.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The biggest weak spot is error handling and persistent storage. Right now, all cached data is lost when the app is closed, and error messages are pretty generic. Also, the UI could be enhanced with more animation or richer recipe content.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
Right now, all cached data is lost when the app is closed (depends on future project features - such as if the api is expected to return different recipes each time the api is hit and etc). If the api were to only return this fixed unchanging set of data, I would save the data to the disk using File Manager.
