# Computer Science 101 for Jake Stein

> Everything you need to know about how software works, explained through the lens of Tryps.
>
> April 2026 · Plane reading edition · ~30 min
> Compiled from Marty's nightly lessons + new material
>
> **See also:** [[obsidian-101-for-jake-stein]] · [[shared/state|Tryps State]] · [[scopes/INDEX|All Scopes]]

---

## Table of Contents

### Part I — The Basics
1. [What Is a Computer, Actually?](#ch1)
2. [RAM vs. Storage](#ch2)
3. [The Terminal & CLI](#ch3)
4. [What Is Code?](#ch4)
5. [JSON: The Universal Language of Data](#ch5)

### Part II — The Internet
6. [DNS: The Internet's Phone Book](#ch6)
7. [HTTP: How Your Phone Talks to the Server](#ch7)
8. [Ports: The Numbered Doors](#ch8)
9. [APIs: How Software Talks to Software](#ch9)
10. [Webhooks: Reverse APIs](#ch10)

### Part III — The Tryps Stack
11. [Frontend vs. Backend](#ch11)
12. [The Tryps Stack: Expo, TypeScript, Supabase](#ch12)
13. [React Native & Why It Matters](#ch13)
14. [TypeScript: JavaScript with Guardrails](#ch14)
15. [Databases: Tables, Rows, and SQL](#ch15)

### Part IV — Building & Shipping
16. [Git: Version Control](#ch16)
17. [CI/CD: The Robot Gatekeeper](#ch17)
18. [The App Store Pipeline](#ch18)
19. [Environment Variables & Secrets](#ch19)

### Part V — Security & Auth
20. [Authentication: Proving Who You Are](#ch20)
21. [OAuth: The Valet Key](#ch21)
22. [Encryption & HTTPS](#ch22)

### Part VI — Performance & Scale
23. [Database Indexing](#ch23)
24. [Caching: Why Things Are Fast (or Stale)](#ch24)
25. [Real-Time Data: WebSockets & Subscriptions](#ch25)
26. [Rate Limiting](#ch26)

### Part VII — Infrastructure
27. [Servers, Cloud, and Serverless](#ch27)
28. [MCP: The New Way Tools Talk to AI](#ch28)
29. [AI Agents: How Marty Works](#ch29)
30. [Putting It All Together: The Life of a Tryps Invite](#ch30)

---

# Part I — The Basics

---

## Chapter 01: What Is a Computer, Actually? {#ch1}
*The four things every computer does*

Every computer — your MacBook, your iPhone, Marty's Hetzner server, the machines running Supabase — does exactly four things:

1. **Input:** Takes in data (keyboard, touchscreen, network request, iMessage)
2. **Storage:** Saves data for later (SSD, database, file system)
3. **Processing:** Transforms data (runs your code, does math, makes decisions)
4. **Output:** Sends results somewhere (screen, API response, push notification)

That's it. Every feature in Tryps — from creating a trip to sending a poll to booking a flight — is a combination of those four operations happening millions of times per second.

> **Analogy:** A computer is a very fast, very obedient, very literal assistant. It will do exactly what you tell it, millions of times per second, and never get tired. But it has zero judgment — if you tell it to do something stupid, it will do it stupidly, very fast. That's why bugs exist: the computer did exactly what the code said, and the code was wrong.

**How this shows up in Tryps:** When a user taps "Join Trip" on an invite link: **Input** = the tap. **Processing** = the app checks if the user is authenticated, adds them to the trip in the database. **Storage** = the new membership is saved in Supabase. **Output** = the trip screen loads with their name in the member list. Every single screen in the app is this loop running over and over.

---

## Chapter 02: RAM vs. Storage {#ch2}
*Why your phone gets slow when you have 47 apps open*

Your computer has two kinds of memory, and they do very different jobs:

**Storage (SSD/hard drive)** is like a filing cabinet. It holds everything permanently — your apps, your photos, your databases. When you turn the computer off and back on, everything in storage is still there. Your iPhone has 128GB or 256GB of this. It's big but relatively slow.

**RAM (Random Access Memory)** is like your desk. It holds whatever you're actively working on right now. It's extremely fast — 100x faster than storage — but it's temporary. When you close an app or restart your phone, everything in RAM disappears. Your iPhone has about 6GB of this.

> **Analogy:** You're planning a group trip. Your filing cabinet (storage) has every trip document you've ever made — hundreds of folders. But your desk (RAM) can only hold maybe 10 folders open at once. When you need a new folder, you have to put one back in the cabinet to make room. That's what your phone does when it "kills" a background app — it's clearing desk space.

**How this shows up in Tryps:** When the Tryps app loads your trip, it pulls data from Supabase (storage — the database on a server) into your phone's RAM. That's why the first load is slower than scrolling around after — the data is already on your "desk." When the app crashes on older phones, it's often because RAM ran out: too many images, too many trip members, too much data held in memory at once. Marty's Hetzner server has 16GB of RAM — enough to hold many conversations in memory simultaneously.

**The "aha" moment:** When someone says "the database is slow," they usually mean data is being read from storage (disk) instead of RAM (cache). When someone says "the app is slow," they usually mean too much is loaded into RAM and the phone is struggling to process it all. Same word ("slow"), completely different problems, completely different fixes.

---

## Chapter 03: The Terminal & CLI {#ch3}
*Why developers type instead of click*

A **CLI (Command Line Interface)** is a text-based way to talk to your computer. Instead of clicking icons and menus (that's a GUI — Graphical User Interface), you type commands. The Terminal app on your Mac is where you access the CLI.

Why would anyone prefer typing over clicking? Three reasons:

1. **Speed:** Typing `git push` is faster than clicking through 5 menus
2. **Automation:** You can chain commands together and run them on a schedule (that's how Marty's cron jobs work)
3. **Power:** Many things simply can't be done with a GUI — there's no "button" to SSH into Marty's server, but `ssh openclaw@178.156.176.44` gets you there instantly

```bash
# Things you do in the terminal every day:
git status                  # see what files changed
git push                    # send code to GitHub
npx expo start              # run the Tryps app locally
ssh openclaw@178.156.176.44 # connect to Marty's server
npx clickup-cli create ...  # create a ClickUp task
```

**How this shows up in Tryps:** Claude Code is a CLI tool — you talk to Claude by typing in the terminal. Marty runs entirely via CLI commands on the Hetzner server — there's no GUI. When you type `/browse` or `/ship`, those are CLI commands that trigger skills. The entire dev workflow — writing code, testing, committing, deploying — happens in the terminal.

---

## Chapter 04: What Is Code? {#ch4}
*Instructions for the very literal assistant*

Code is a set of instructions written in a programming language that tells the computer what to do. It's like a recipe: specific steps, in a specific order, with specific ingredients.

Here's a real piece of code that could exist in Tryps:

```typescript
// When someone joins a trip, notify all existing members
async function onMemberJoined(tripId, newMember) {
  const trip = await getTrip(tripId);
  const members = trip.members.filter(m => m.id !== newMember.id);

  for (const member of members) {
    await sendPushNotification(member.id, {
      title: `${newMember.name} joined ${trip.name}!`,
      body: `The group is now ${trip.members.length} people.`
    });
  }
}
```

Reading this top to bottom: when someone joins, get the trip, get all the other members, then for each one, send a push notification. The computer reads this literally and executes each line in order.

**The "aha" moment:** Code is not math. It's not genius-level abstract thinking. It's *instructions*. Most bugs happen not because the logic is complex, but because the instructions didn't account for a situation. "What if the trip has zero other members? What if the member already joined twice? What if the push notification service is down?" Every bug is a missing instruction.

---

## Chapter 05: JSON: The Universal Language of Data {#ch5}
*How everything in Tryps gets passed around*

JSON (JavaScript Object Notation) is the format that nearly all modern software uses to pass data around. It looks like this:

```json
{
  "trip_name": "Barcelona Summer 2026",
  "created_by": "Jake",
  "members": ["Jake", "Sean", "Cameron"],
  "dates": {
    "start": "2026-07-15",
    "end": "2026-07-22"
  },
  "is_booked": false,
  "member_count": 3
}
```

It's just key-value pairs — labels on the left, values on the right. Values can be text (strings), numbers, true/false (booleans), lists (arrays), or nested objects. That's it. Every API, every database query, every piece of data flowing through Tryps is JSON.

**How this shows up in Tryps:** When one of the iMessage bugs says "agent returns JSON instead of a human message" — that means the agent accidentally sent the raw data format instead of converting it to natural language first. The user sees `{"trip_name": "Barcelona"}` instead of "Your Barcelona trip is set for July 15-22!" The data is correct; the formatting step was missing.

---

# Part II — The Internet

---

## Chapter 06: DNS: The Internet's Phone Book {#ch6}
*What happens when someone types jointryps.com*

When you type **jointryps.com** into a browser, your computer has no idea where that is. It's like saying "take me to Jake's apartment" — you need an address first. DNS (Domain Name System) is the internet's phone book. It translates human-readable names like `jointryps.com` into IP addresses like `76.76.21.93` — the actual "street address" of the server where Tryps lives.

Here's what happens in ~100 milliseconds when someone opens Tryps:

1. Browser asks your Wi-Fi router: "Where is jointryps.com?"
2. Router doesn't know, so it asks your ISP's DNS server (like Verizon or Google's 8.8.8.8)
3. ISP asks the **.com registry**: "Who handles jointryps.com?"
4. Registry says: "Ask Vercel's nameservers" (because that's where Tryps' DNS is configured)
5. Vercel's nameserver responds: "jointryps.com lives at 76.76.21.93"
6. Browser connects to that IP and Tryps loads

**How this shows up in Tryps:** When Nadeem's PR #333 consolidated all `jointripful.com` references to `jointryps.com`, DNS is what makes sure both domains eventually reach the same server. The deep link scheme (`tripful://`) works differently — that's handled by the phone's OS, not DNS — but the web landing pages, OG images, and the invite link all depend on DNS resolving correctly. If DNS is misconfigured, every invite link is broken.

**The "aha" moment:** DNS is why a domain costs money — you're paying for a permanent entry in the internet's phone book that says "this name belongs to this server." Change your server? Just update the phone book entry. That's what "DNS propagation" is: waiting for every copy of the phone book worldwide to get the update. It can take up to 48 hours because there are millions of copies.

---

## Chapter 07: HTTP: How Your Phone Talks to the Server {#ch7}
*The request-response conversation behind every tap*

Once your phone knows the server's address (thanks to DNS), it needs to actually **talk** to it. HTTP (HyperText Transfer Protocol) is the language of that conversation. Every time you open the Tryps app, scroll through trips, or tap "Join Trip," your phone is having a rapid-fire HTTP conversation with Supabase.

> **Analogy:** Think of it like ordering at a restaurant. You (the app) say: **"GET me the trip details for trip ID 47."** The server responds: **"200 OK — here's the trip name, members, itinerary, and vibe."** The client asks, the server answers. Always.

The common "verbs" are:

- **GET** — "Give me this data" (loading a trip, fetching a member list)
- **POST** — "Create something new" (creating a trip, adding an activity)
- **PUT/PATCH** — "Update this thing" (changing a trip name, editing an itinerary item)
- **DELETE** — "Remove this" (leaving a trip, deleting an activity)

The numbers you sometimes see — 200, 404, 500 — are the server's way of saying how it went:

- **200** = "Here you go." (Success)
- **401** = "Who are you? Show me your auth token." (Unauthorized)
- **404** = "That doesn't exist." (Not found)
- **500** = "Something broke on my end." (Server error)

**How this shows up in Tryps:** When the iMessage agent creates a trip, it's making POST requests. When you open the app and don't see that trip, the GET request either hasn't fired, returned stale data, or the real-time subscription (WebSocket, a cousin of HTTP — see Chapter 25) dropped. When Nadeem's real-time data updates aren't reflecting, it's often because the app sent a POST to create something but isn't sending a follow-up GET to refresh, or the response came back but the UI didn't re-render.

**The "aha" moment:** HTTP is stateless — the server has no memory of previous requests. Every single tap in the app is a fresh conversation: "Hi, who are you? Here's my auth token. Can I have this data?" That's why auth tokens exist — they're your ID badge that you show on every single request, because the server has amnesia.

---

## Chapter 08: Ports: The Numbered Doors {#ch8}
*Why "Port 3000" keeps coming up in dev conversations*

When your computer connects to the internet, it's not just connecting to "a server" — it's connecting to a specific *door* on that server. These doors are called **ports**. There are 65,535 of them on every computer.

> **Analogy:** Think of a server as an office building. The building has one street address (that's the IP address — like 178.156.176.44, Marty's server). But inside, there are thousands of office suites. Suite 80 is the web server (HTTP). Suite 443 is the secure web server (HTTPS). Suite 22 is SSH (remote login). Suite 5432 is PostgreSQL (the database).

Common port numbers and what lives there:

- **80** — HTTP (plain web traffic)
- **443** — HTTPS (encrypted web traffic)
- **22** — SSH (remote terminal access)
- **5432** — PostgreSQL (Supabase's database)
- **3000** — Common dev server port (Next.js, Express)
- **8081** — Expo dev server (React Native)

**How this shows up in Tryps:** When Nadeem runs the Expo dev server, it starts on port 8081. When Supabase runs locally, it's on port 54321. If two services try to use the same port, one crashes — like two tenants fighting over the same office suite. When Marty's server runs OpenClaw, it listens on a specific port for Slack messages. "Port already in use" is one of the most common developer errors.

**The "aha" moment:** A URL like `http://localhost:3000` means "talk to my own computer (localhost), door number 3000." Every running service picks a door. The internet is just millions of computers, each with thousands of numbered doors, all talking to each other through those doors.

---

## Chapter 09: APIs: How Software Talks to Software {#ch9}
*The contracts between services*

An **API (Application Programming Interface)** is a set of rules for how one piece of software can talk to another. It's a contract: "If you send me this kind of request, I'll send you back this kind of response."

> **Analogy:** Think of a restaurant menu. You don't walk into the kitchen and cook your own food. You look at the menu (the API documentation), pick what you want (make a request), and the kitchen (the server) sends it out (the response). You don't need to know how the chef made it — you just need to know what's available and how to order.

Tryps talks to a bunch of APIs:

- **Supabase API** — Store and retrieve trip data, user profiles, itineraries
- **Duffel API** — Search and book flights
- **Stripe API** — Handle payments
- **ElevenLabs API** — Generate voice for the phone agent
- **Apple Push Notification Service** — Send push notifications to iPhones
- **iMessage / Linq API** — Send and receive iMessages

**How this shows up in Tryps:** When Rizwan says "Duffel is pending production approval," he means the Duffel API gave us a sandbox key (for testing with fake data) but hasn't given us a production key (for real flight bookings with real money). The code is ready; we're waiting for the API provider to let us through the door. Every third-party integration in Tryps is gated by API access.

---

## Chapter 10: Webhooks: Reverse APIs {#ch10}
*When the server calls you instead of you calling it*

Normal API calls work like this: you ask the server for something, it responds. But sometimes you need the server to tell *you* when something happens. That's a **webhook** — it's an API in reverse.

> **Analogy:** Normal API = you calling the restaurant to ask if your table is ready. Webhook = the restaurant calling *you* when the table is ready. Much more efficient — you don't have to keep calling every 5 minutes.

You give a service a URL (your "phone number") and say: "When X happens, send a message to this URL." The service then POSTs data to your URL whenever that event occurs.

**How this shows up in Tryps:** When Stripe processes a payment, it sends a webhook to Tryps: "Payment succeeded for $247 from Jake." Tryps doesn't need to keep asking Stripe "did it work yet?" — Stripe proactively tells us. When someone sends an iMessage to the Tryps number (+1 917 745 3624), Linq sends a webhook to Marty's server with the message content. That's how the agent knows someone texted — it didn't read the iMessage directly, it received a webhook notification.

---

# Part III — The Tryps Stack

---

## Chapter 11: Frontend vs. Backend {#ch11}
*The restaurant dining room vs. the kitchen*

**Frontend** is everything the user sees and touches. The Tryps app screens, the buttons, the animations, the trip card layout — that's frontend. It runs on the user's device (their iPhone).

**Backend** is everything that happens behind the scenes. The database, the authentication, the flight search, the agent logic — that's backend. It runs on servers somewhere in the cloud.

> **Analogy:** **Frontend** = the restaurant's dining room. The decor, the menu design, the table layout, the way the waiter presents the food. **Backend** = the kitchen. The recipes, the ingredient storage, the prep work, the cooking. A beautiful dining room with a terrible kitchen = a bad restaurant. A great kitchen with an ugly dining room = an underappreciated one.

In Tryps:

- **Nadeem** works mostly on frontend (the app screens — output-backed screen, itinerary UI, vibe tab)
- **Rizwan** works mostly on backend (agent intelligence, recommendation engine, booking pipeline)
- **Asif** works across both (iMessage agent is backend logic that outputs to a frontend — the iMessage conversation)

**The "aha" moment:** When a bug report says "the itinerary isn't showing" — it could be a frontend bug (the screen isn't rendering the data it already has) or a backend bug (the server isn't returning the data). The first step in any bug is figuring out which side broke. That's why the devs check "network requests" — they're looking at the boundary between frontend and backend to see where the data stopped flowing.

---

## Chapter 12: The Tryps Stack {#ch12}
*Expo + TypeScript + Supabase — what each piece does*

A "tech stack" is the combination of tools and technologies used to build an app. Here's what Tryps uses and why:

### Expo
**What it is:** A framework built on top of React Native that makes it easier to build mobile apps for iOS and Android from a single codebase.

**Why Tryps uses it:** Instead of writing the app twice (once in Swift for iPhone, once in Kotlin for Android), you write it once in JavaScript/TypeScript and Expo handles making it work on both platforms. It also handles the App Store build process, push notifications, camera access, and dozens of other native features.

**The tradeoff:** Slightly less native performance than a pure Swift app, but 50-70% less development time. For a startup, speed wins.

### TypeScript
**What it is:** JavaScript with types added — a way to catch bugs before the code runs (more in Chapter 14).

**Why Tryps uses it:** JavaScript is the language of the web and React Native. TypeScript adds safety rails so you catch errors while writing code instead of when users hit them.

### Supabase
**What it is:** An open-source backend-as-a-service. It gives you a PostgreSQL database, authentication, real-time subscriptions, file storage, and serverless functions — all managed for you.

**Why Tryps uses it:** Instead of building and maintaining your own server, database, auth system, and file storage, Supabase handles all of that. The team can focus on trip features instead of infrastructure. It's like renting a fully furnished apartment instead of building a house from scratch.

---

## Chapter 13: React Native & Why It Matters {#ch13}
*One codebase, two app stores*

**React Native** is a framework created by Facebook (Meta) that lets you build native mobile apps using JavaScript. "Native" means the app uses real iOS and Android components — it's not a website pretending to be an app.

The key idea: you write **components**. A component is a reusable building block — a button, a trip card, a member avatar, a poll widget. You compose these together to build screens.

```tsx
// A simplified Tryps trip card component
function TripCard({ trip }) {
  return (
    <Card>
      <TripImage source={trip.coverPhoto} />
      <Title>{trip.name}</Title>
      <DateRange start={trip.startDate} end={trip.endDate} />
      <MemberAvatars members={trip.members} />
    </Card>
  );
}
```

This same code produces a real iOS card on iPhones and a real Android card on Android phones. The framework translates the JavaScript into native UI elements for each platform.

**How this shows up in Tryps:** The "output-backed screen" scope (Nadeem's 48 SCs) is essentially building React Native components that render data from the agent. Every screen in the app — trip details, itinerary, people tab, vibe tab — is a tree of React Native components receiving data from Supabase and displaying it. When Expo pushes an update, it can update the JavaScript bundle without going through the App Store — that's "over-the-air updates," one of Expo's killer features.

---

## Chapter 14: TypeScript: JavaScript with Guardrails {#ch14}
*Why the team uses TS instead of plain JS*

**JavaScript** is the programming language that runs in browsers and React Native. It's flexible, fast to write, and everywhere. But it has a problem: it doesn't check your work until the code runs.

**TypeScript** adds "types" — labels that tell the computer what kind of data something is. This lets it catch mistakes before the code ever runs.

```typescript
// JavaScript (no types — danger)
function addMember(trip, member) {
  trip.members.push(member); // what if trip is null? what if members doesn't exist?
}

// TypeScript (with types — safe)
function addMember(trip: Trip, member: Member): void {
  trip.members.push(member); // TS guarantees trip has a members array
}
```

The `: Trip` and `: Member` annotations tell TypeScript exactly what shape the data must have. If someone tries to call `addMember("hello", 42)`, TypeScript will catch it immediately — before the app runs, before users see a crash.

**The "aha" moment:** TypeScript doesn't run in production. It's a development tool. Before the app ships, TypeScript gets "compiled" into plain JavaScript (which is what actually runs on the phone). Think of it as spell-check: it catches errors while you're writing, but the final published document doesn't have red underlines in it.

---

## Chapter 15: Databases: Tables, Rows, and SQL {#ch15}
*Where all of Tryps' data actually lives*

A **database** is an organized collection of data. Tryps uses **PostgreSQL** (via Supabase) — a relational database, which means it stores data in **tables**, like spreadsheets.

```
-- The "trips" table might look like this:

id         | name                 | destination  | start_date | created_by
-----------+----------------------+--------------+------------+-----------
abc123     | Barcelona Summer     | Barcelona    | 2026-07-15 | jake_001
def456     | Ski Trip             | Whistler     | 2026-12-20 | sean_002
ghi789     | Austin F1 Weekend    | Austin       | 2026-10-18 | cam_003
```

**SQL (Structured Query Language)** is how you ask the database questions:

```sql
-- Get all trips Jake created
SELECT * FROM trips WHERE created_by = 'jake_001';

-- Count how many members each trip has
SELECT trip_id, COUNT(*) FROM trip_members GROUP BY trip_id;

-- Add a new activity
INSERT INTO activities (trip_id, name, date) VALUES ('abc123', 'Sagrada Familia', '2026-07-17');
```

**Tables relate to each other.** A `trips` table connects to a `trip_members` table connects to a `users` table. That's "relational" — the data forms a web of relationships.

**How this shows up in Tryps:** Supabase gives us a PostgreSQL database with a nice dashboard for browsing tables. When Rizwan writes agent intelligence logic, he's writing queries that read from and write to these tables. When the app loads a trip, it's running SQL under the hood. Every bug that says "data not showing up" starts with checking: is the data actually in the table?

---

# Part IV — Building & Shipping

---

## Chapter 16: Git: Version Control {#ch16}
*How the team works on the same code without breaking each other's work*

**Git** is a system that tracks every change to every file in a project, like an infinitely detailed "Track Changes" for code. It lets multiple people work on the same codebase simultaneously without overwriting each other.

Key concepts:

- **Repository (repo):** The project folder tracked by Git. Tryps lives in the `t4` repo on GitHub.
- **Commit:** A snapshot of changes. "I changed these 5 files, here's why." Every commit has a message and a unique ID.
- **Branch:** A parallel version of the code. The `develop` branch is the "current working version." Each developer creates their own branch (like `nadeem/itinerary-fixes`) to work in isolation.
- **Merge:** Combining a branch back into `develop`. "My feature is done, put it in the main codebase."
- **Pull Request (PR):** A formal request to merge. Other developers review the code before it gets merged. That's why you see "PR #352" in standups.
- **Merge conflict:** When two people changed the same lines and Git doesn't know which version to keep. Someone has to manually decide.

**How this shows up in Tryps:** PR #333 has been stuck for days because of a merge conflict — Nadeem and someone else changed the same file. The 14 stale PRs mean 14 sets of changes sitting in limbo, not in the app. When you hear "CI is failing," it means the automated checks that run on every PR found a problem. The `develop` branch is the source of truth — whatever's on `develop` is what gets built into the TestFlight app.

---

## Chapter 17: CI/CD: The Robot Gatekeeper {#ch17}
*Why all your PRs keep failing*

**CI** stands for Continuous Integration. When a developer pushes code, a robot automatically runs all the tests, checks the code style, and tries to build the app. If anything breaks, the PR gets a red X.

**CD** stands for Continuous Delivery/Deployment. If the robot says everything's green, the code automatically gets deployed.

> **Analogy:** CI is the health inspector checking every dish before it leaves the kitchen. CD is the waiter delivering it to the table. If the inspector finds a problem, the dish goes back to the chef — the customer never sees it.

The CI pipeline typically runs:

1. **Lint:** Are there any code style violations? (Like a spell-checker for code)
2. **Type check:** Does the TypeScript compile without errors?
3. **Tests:** Do all the automated tests pass?
4. **Build:** Can the app actually be built into a working binary?

**How this shows up in Tryps:** Your 13 bug-fix PRs from the weekend all had red X marks because CI was failing. This doesn't necessarily mean YOUR code was broken — it could mean the tests themselves are outdated, a dependency changed, or the build environment has a problem. The fix might be 10 minutes of work, but until someone looks at the CI logs and figures out what's actually failing, nothing can merge.

**The "aha" moment:** CI isn't testing your code in isolation — it's testing whether your code works *with everyone else's code*. That's why something you wrote alone on Saturday night might fail on Monday when it has to play nice with what Nadeem pushed on Sunday.

---

## Chapter 18: The App Store Pipeline {#ch18}
*From code to a user's phone*

Getting an app from "code on a developer's laptop" to "installed on a user's iPhone" is a multi-step process:

1. **Write code** — Developers write TypeScript in the t4 repo
2. **Build** — Expo compiles the code into a native iOS binary (an .ipa file). This happens on Expo's build servers (EAS Build) because it requires macOS and Xcode.
3. **TestFlight** — Apple's beta testing platform. The .ipa gets uploaded here. Beta testers (you, QA team) can install it immediately.
4. **App Review** — Apple's human reviewers check the app for quality, security, and compliance. Takes 1-3 days. They can reject it.
5. **App Store** — Once approved, the app is live. Users can download it.

**Over-the-air (OTA) updates** are the shortcut: Expo can push JavaScript changes directly to installed apps without going through the App Store. This means bug fixes can ship in minutes instead of days. But native code changes (new permissions, new native modules) still require a full App Store update.

**How this shows up in Tryps:** The April 15 deadline is "App Store submitted" — that means the .ipa has been uploaded and is in Apple's review queue. If Apple rejects it (common reasons: crashes, broken features, missing privacy descriptions), the clock resets. That's why QA matters — every bug that makes it into the submission is a potential rejection. TestFlight is where the QA team (Aman, Sarfaraz, Zain) tests before submission.

---

## Chapter 19: Environment Variables & Secrets {#ch19}
*Why API keys don't go in the code*

An **environment variable** is a value stored outside the code that the code reads at runtime. Think of it as a config setting that changes depending on where the code is running.

Why not just put these values directly in the code?

- **Security:** API keys, database passwords, and secrets should never be in code. Code lives on GitHub — if anyone can see the code, they can see the secrets.
- **Flexibility:** The Supabase URL is different for development (localhost) vs. production (cloud). Environment variables let the same code work in both places.

```bash
# In ~/.zshrc (your shell config):
export CLICKUP_API_KEY="pk_12345..."
export SUPABASE_URL="https://abc123.supabase.co"

# In code:
const supabase = createClient(process.env.SUPABASE_URL);
```

The `.env` file is where environment variables live in a project. The `.gitignore` file tells Git to never upload `.env` to GitHub. If someone accidentally commits a secret, it's a security incident — the key needs to be immediately rotated (replaced with a new one).

**How this shows up in Tryps:** Your ClickUp API key is in `~/.zshrc` as an environment variable. Marty's API keys are on the Hetzner server in environment variables. The Supabase keys, Stripe keys, Duffel keys — all stored as env vars, never in the code. When someone says "it works locally but not in production," the first thing to check is: are the environment variables set correctly in the production environment?

---

# Part V — Security & Auth

---

## Chapter 20: Authentication: Proving Who You Are {#ch20}
*Sessions, tokens, and why you stay logged in*

**Authentication (auth)** is the process of proving you are who you claim to be. In the physical world, it's showing your ID. In the digital world, it's entering a password, tapping a magic link, or using Face ID.

Here's how Tryps auth works (simplified):

1. User opens the app and enters their phone number
2. Supabase sends a one-time code via SMS (OTP — One Time Password)
3. User enters the code
4. Supabase verifies it matches, then sends back an **auth token** — a long, random string that proves "this person authenticated successfully"
5. The app stores this token securely on the phone
6. Every API request includes this token in the header: "Here's my proof, give me my data"

**Authorization** is different from authentication. Auth*entication* = "Who are you?" Auth*orization* = "What are you allowed to do?" You might be authenticated as Jake, but are you authorized to delete Sean's trip? That's a separate check.

**The "aha" moment:** The reason you stay logged into the Tryps app for weeks is that the auth token hasn't expired yet. When you suddenly get logged out, it's because the token expired (or Supabase rotated it). "Session management" is just the science of how long tokens last and when they get refreshed.

---

## Chapter 21: OAuth: The Valet Key {#ch21}
*How "Sign In with Google" works*

Tryps wants to access Jake's Google Calendar (to create standup events). But Jake shouldn't give Tryps his Google password. **OAuth** is the protocol that solves this: "Let an app access your stuff without giving it your password."

The dance (simplified):

1. **Tryps** says to **Google**: "Jake wants to let me see his calendar."
2. **Google** shows **Jake** a consent screen: "Tryps wants access to your Calendar. Allow?"
3. Jake clicks "Allow."
4. Google gives Tryps two tokens:
   - **Access token:** A temporary pass (expires in ~1 hour) that lets Tryps read/write the calendar
   - **Refresh token:** A permanent pass that lets Tryps get new access tokens without bothering Jake again
5. Tryps stores both tokens securely. Every hour, it uses the refresh token to get a fresh access token.

> **Analogy:** OAuth is a valet key for your digital life. You're not giving Tryps the master key to your Google account — you're giving it a limited key that only opens specific doors (Calendar, Gmail) and can be revoked any time.

**How this shows up in Tryps:** Every time Marty creates a calendar event or reads your email, he's using an OAuth access token. When you see "gog auth error" in the logs, it means the access token expired and the refresh token couldn't renew it (usually because Google revoked it for security). The fix: Jake re-authorizes via the consent screen, which issues new tokens.

---

## Chapter 22: Encryption & HTTPS {#ch22}
*Why the padlock in the URL bar matters*

**Encryption** is the process of scrambling data so only the intended recipient can read it. When you see `https://` (note the "s") or a padlock icon in your browser, that means the connection between your device and the server is encrypted.

> **Analogy:** Imagine sending a postcard vs. a sealed letter. HTTP (no "s") is the postcard — anyone who handles it along the way can read it. HTTPS is the sealed letter — only you and the recipient can read the contents. The "seal" is a technology called TLS (Transport Layer Security).

Without HTTPS, anyone on the same Wi-Fi network (say, airport Wi-Fi) could intercept the data flowing between your phone and Supabase — including auth tokens, trip details, and payment information.

**How this shows up in Tryps:** All Supabase connections are HTTPS by default — you don't need to configure anything. The Tryps website (jointryps.com on Vercel) gets free HTTPS certificates automatically. Stripe *requires* HTTPS — they won't process payments over an unencrypted connection. When you SSH into Marty's server, that connection is also encrypted (SSH is like HTTPS for terminal access).

---

# Part VI — Performance & Scale

---

## Chapter 23: Database Indexing {#ch23}
*Why some queries are instant and others take forever*

> **Analogy:** Imagine a library with 100,000 books. If you want "The Great Gatsby," you have two options:
> - **No index:** Start at shelf 1, check every book. On average, you'll check 50,000 books before finding it. (This is a "full table scan.")
> - **With index:** Check the card catalog, which tells you it's on shelf 47, position 12. Two lookups. Done. (This is an "index lookup.")

In PostgreSQL, the `trips` table might have 10,000 rows eventually. When you query `SELECT * FROM trips WHERE id = 'abc123'`, PostgreSQL uses the primary key index to find it in microseconds. But if you query `SELECT * FROM trips WHERE destination LIKE '%Barcelona%'` without an index on `destination`, it scans every single row.

**The tradeoff:** Indexes make reads fast but writes slower (every INSERT also has to update the index). It's like maintaining the card catalog — every time you add a book, you also update the catalog. Worth it for columns you search often; wasteful for columns you rarely filter by.

**The "aha" moment:** When the app feels slow loading trips, it's almost never the network — it's usually a missing database index causing PostgreSQL to read thousands of rows instead of jumping straight to the one it needs. Adding an index is often a one-line fix that makes a query 1000x faster.

---

## Chapter 24: Caching: Why Things Are Fast (or Stale) {#ch24}
*The tradeoff between speed and freshness*

A **cache** is a temporary copy of data stored somewhere faster than the original source. Instead of fetching from the database every time, you check the cache first.

> **Analogy:** You look up a restaurant's hours online (slow — open browser, search, find the site). Then you write it on a sticky note on your desk (the cache). Next time you need the hours, you just glance at the sticky note (fast). But if the restaurant changes their hours, your sticky note is wrong — that's "stale cache."

Caching happens at every level:

- **Browser/app cache:** Images and data stored on the phone so they don't re-download every time
- **CDN (Content Delivery Network):** Copies of your website stored on servers worldwide so users get a nearby copy (Vercel does this for jointryps.com)
- **Database cache:** Frequently-accessed queries stored in RAM so the database doesn't re-compute them
- **DNS cache:** Your router remembers "jointryps.com = 76.76.21.93" so it doesn't re-lookup every time

**How this shows up in Tryps:** When someone says "I added an activity but it's not showing up" — it might be a caching issue. The app has a cached version of the trip data and hasn't fetched the updated version. "Pull to refresh" is literally "throw away the cache and fetch fresh data." OG image previews in iMessage are cached aggressively — if you update the trip card image, existing previews might show the old one for hours or days.

**The "aha" moment:** There's a famous joke in computer science: "There are only two hard things — cache invalidation and naming things." Cache invalidation is deciding *when* to throw away the old copy and get a fresh one. Too soon = you lose the speed benefit. Too late = users see stale data. It's genuinely one of the hardest problems in software.

---

## Chapter 25: Real-Time Data: WebSockets & Subscriptions {#ch25}
*How the app updates without refreshing*

Normal HTTP is request-response: the app asks, the server answers, the conversation ends. But what if you want the server to tell you when something changes — instantly, without asking?

**WebSockets** are a persistent, two-way connection between the app and the server. Unlike HTTP (which hangs up after each response), a WebSocket stays open. Either side can send a message at any time.

> **Analogy:** HTTP is like texting someone a question and waiting for a reply. WebSocket is like being on a phone call — the line stays open and either person can talk whenever they want.

Supabase offers **real-time subscriptions** built on WebSockets. You tell Supabase: "Notify me whenever the `trip_members` table changes for trip abc123." Then, when anyone joins or leaves that trip, Supabase immediately pushes the update to every connected client.

**How this shows up in Tryps:** This is exactly what Nadeem's "real-time data updates" mission is about. When the iMessage agent adds an activity to a trip, every person with the Tryps app open should see it appear instantly — without pulling to refresh. That requires a WebSocket subscription on the activities table. When real-time isn't working, it's usually because: (1) the subscription wasn't set up for that table, (2) the WebSocket connection dropped (common on mobile with bad signal), or (3) the UI isn't listening for the update event.

---

## Chapter 26: Rate Limiting {#ch26}
*Why APIs say "slow down"*

**Rate limiting** is a server's way of saying: "You're making too many requests. Slow down." It protects servers from being overwhelmed — whether by bugs, bots, or denial-of-service attacks.

> **Analogy:** A nightclub with a bouncer who lets in 100 people per hour. Even if 500 people show up at once, the bouncer keeps the pace manageable. If you keep trying to push past, you get kicked out of line entirely (that's a "429 Too Many Requests" response).

Common rate limits you'll encounter:

- **Supabase:** Free tier = 500 requests/second. Enough for now, could matter at scale.
- **Stripe:** 100 reads/second, 25 writes/second per API key
- **Duffel:** Limits vary by endpoint — flight search is expensive, so they limit it tightly
- **Claude API:** Token-per-minute limits based on your plan

**How this shows up in Tryps:** SC-61 (in the Asif+Rizwan interface session) is specifically about building a rate limiter for the iMessage agent. Without it, if someone sends 50 messages in a row, the agent would try to process all 50 simultaneously — burning tokens, hitting API limits, and potentially crashing. A rate limiter ensures the agent processes one message at a time (or one per second) and queues the rest.

---

# Part VII — Infrastructure

---

## Chapter 27: Servers, Cloud, and Serverless {#ch27}
*Where code actually runs*

All code runs on a computer somewhere. The question is: whose computer?

### Dedicated Server (Hetzner)
A real, physical machine in a data center that you rent by the month. You have full control — install whatever you want, run whatever you want. Marty runs on a Hetzner server at IP 178.156.176.44. It's always on, always yours.

**Pros:** Full control, predictable pricing, great for long-running processes (like an agent that needs to be available 24/7).
**Cons:** You manage everything — updates, security, backups, scaling.

### Cloud Platforms (AWS, Google Cloud, Vercel)
Virtual machines or managed services that scale automatically. Vercel hosts jointryps.com — it handles traffic spikes, SSL certificates, CDN, and deployments automatically.

**Pros:** Managed for you, scales with demand, pay-as-you-go.
**Cons:** Can get expensive at scale, less control, vendor lock-in.

### Serverless (Supabase Edge Functions)
"Serverless" doesn't mean there are no servers — it means you don't think about them. You write a function, deploy it, and it runs when triggered. You only pay when it executes.

**Pros:** Zero infrastructure to manage, scales to zero (no cost when idle), perfect for webhooks and API endpoints.
**Cons:** Cold starts (first request after idle is slower), limited execution time, harder to debug.

**How this shows up in Tryps:** Tryps uses all three: Hetzner for Marty (needs 24/7 uptime), Vercel for the website (needs global CDN and easy deploys), and Supabase for the backend (database + auth + edge functions). This is a very common pattern for startups — mix and match the right tool for each job.

---

## Chapter 28: MCP: The New Way Tools Talk to AI {#ch28}
*CLI vs. MCP and why it matters*

You asked about CLI vs. MCP — here's the difference:

**CLI (Command Line Interface)** is a human typing commands to a computer. You type `git push`, the computer does it. It's been around since the 1960s.

**MCP (Model Context Protocol)** is the new standard (created by Anthropic) for AI models to use tools. Instead of a human typing commands, an AI model sends structured requests to tools. Think of it as "CLI for AI."

> **Analogy:** **CLI** is like a person using a remote control — press buttons, see results. **MCP** is like giving a robot the remote control and teaching it what each button does. The robot can then use the TV on its own, without a human pressing each button.

In practice:

- **CLI:** Jake types `npx clickup-cli create "Fix bug"` to create a task
- **MCP:** Claude Code calls the ClickUp MCP tool automatically: "Create a task called 'Fix bug' in list 901711582339"

MCP is what lets Claude Code browse the web, read Figma files, interact with Chrome, and use Slack — all through structured tool calls instead of bash commands.

**How this shows up in Tryps:** Marty uses MCP tools to interact with Slack, GitHub, and ClickUp. When you see tools like `mcp__slack__slack_post_message` in Claude Code, that's MCP in action. The key insight: MCP makes AI agents dramatically more capable because they can use any tool that has an MCP adapter, just like a human can use any app that has a GUI.

---

## Chapter 29: AI Agents: How Marty Works {#ch29}
*The loop that makes an agent an agent*

An **AI agent** is an AI model that can take actions, not just generate text. The key difference between ChatGPT (a chatbot) and Marty (an agent) is the **action loop**:

1. **Observe:** Read the current state (Slack messages, GitHub PRs, ClickUp tasks)
2. **Think:** Decide what to do based on instructions and context
3. **Act:** Execute actions (post a message, create a standup, write a report)
4. **Observe again:** Check if the action worked, adjust if needed
5. Repeat forever

This is called the "agentic loop." Marty runs this loop on a schedule (cron jobs) and on demand (when you DM him on Slack).

### What makes Marty work

- **Runtime:** OpenClaw on Hetzner server (always on)
- **Model:** Claude Opus 4.6 (for complex tasks), Sonnet 4.6 (for routine tasks)
- **Tools:** GitHub API, Slack API, ClickUp API, file system, bash commands
- **Memory:** Files in tryps-docs/shared/ that persist between conversations
- **Triggers:** Cron jobs (8pm standup, 8:30pm nightly report) + Slack DMs

**The "aha" moment:** The thing that makes agents powerful isn't the AI model — it's the tools. GPT-4 without tools is a chatbot. GPT-4 with tools (file system, APIs, browser) is an agent. The model is the brain; the tools are the hands. Marty's "intelligence" comes from Claude Opus, but his *usefulness* comes from being connected to your actual systems.

---

## Chapter 30: Putting It All Together {#ch30}
*The life of a Tryps invite link*

Let's trace what happens when someone sends a Tryps invite and a friend joins. Every chapter in this guide shows up:

### Step 1: Jake creates a trip via iMessage

Jake texts the Tryps number (+1 917 745 3624): "Create a Barcelona trip for July 15-22."

- The text arrives via Linq's **webhook** (Ch 10) to Marty's **server** (Ch 27) on a specific **port** (Ch 8)
- Marty's **agent loop** (Ch 29) processes the message using **MCP tools** (Ch 28)
- A **POST request** (Ch 7) sends **JSON** (Ch 5) to Supabase's **API** (Ch 9) over **HTTPS** (Ch 22)
- Supabase writes the trip to the **database** (Ch 15) using **SQL**
- The agent generates an invite link: `https://jointryps.com/trip/abc123`

### Step 2: The friend taps the invite link

- **DNS** (Ch 6) resolves `jointryps.com` to Vercel's IP address
- The browser connects over **HTTPS** (Ch 22) — encrypted, secure
- Vercel's **CDN** (Ch 24) serves the landing page from the nearest server
- The page shows the trip card with an OG image (rendered **server-side**, Ch 11)
- A deep link redirects to the Tryps app (or the App Store if not installed, Ch 18)

### Step 3: The friend joins the trip in the app

- The app checks **authentication** (Ch 20) — is this person logged in? Auth token valid?
- If not, the phone number + OTP flow runs (stored as **environment variables**, Ch 19)
- A **POST request** (Ch 7) adds the friend to the `trip_members` table in the **database** (Ch 15)
- Supabase's **real-time subscription** (Ch 25) pushes the update to everyone who has the trip open
- The **React Native** component (Ch 13) re-renders the member list, written in **TypeScript** (Ch 14)
- A push notification fires to all existing members
- If the agent was rate-limited (Ch 26), it queues the notification

### Step 4: The code behind this was shipped through

- A developer wrote the code in a **Git branch** (Ch 16)
- **CI/CD** (Ch 17) ran tests and verified it builds
- The PR was reviewed, merged to `develop`, and built via **Expo/EAS** (Ch 18)
- The build was uploaded to **TestFlight**, QA tested it, and it shipped to the **App Store** (Ch 18)

---

That's everything. Every chapter in this guide is a layer in the stack that makes Tryps work. You don't need to understand every layer deeply — but knowing they exist, what they do, and how they connect means you can have informed conversations with your dev team, ask better questions, and make better product decisions.

The most important thing a technical founder can do isn't write code — it's understand the system well enough to know where things break and why.

**Final "aha" moment:** Software is layers of abstraction. DNS abstracts IP addresses. HTTP abstracts network connections. APIs abstract databases. React Native abstracts iOS and Android. Each layer hides complexity and exposes a simpler interface. When something breaks, it's usually at the boundary between two layers. Knowing the layers means knowing where to look.

---

*CS 101 for Jake Stein · April 2026 · Compiled by Claude from Marty's nightly lessons*
*Tryps — jointryps.com*
