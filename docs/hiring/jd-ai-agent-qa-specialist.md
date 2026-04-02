# AI Agent QA Specialist — Upwork Job Description

> Internal doc. Copy the section below into Upwork.

---

## Title

AI Agent QA & Evaluation Specialist — iMessage Travel Agent

## Description

### About Us

Tryps is a travel app that puts an AI travel agent directly in your iMessage group chat. Think Partiful but for travel — one person adds the agent to their group thread, and it helps the whole group plan their trip: voting on activities, splitting expenses, building an itinerary, nudging when plans stall. No app download required to participate.

The agent (we call it Linq) is powered by Claude and has a strict personality standard: **if you told your grandmother the agent was a human travel agent named Jennifer, she would 100% believe it.** That's the bar. That's what you're helping us hit.

### The Role

We're hiring an AI Agent QA Specialist to spend their days talking to our iMessage agent across hundreds of scenarios — testing its responses, personality, intelligence, and failure modes. This is not traditional software QA. You're evaluating a conversational AI agent that lives in real group chats.

**Your job is to:**

- **Run structured tests** against 100+ documented success criteria across the agent's capabilities (onboarding, expense tracking, voting, trip planning, proactive behavior, personality)
- **Simulate real group dynamics** — play multiple personas in group chats using tools like BrowserStack to mock multiple iPhones. You're the planner, the passive friend, the difficult one, the one who never responds
- **Do exploratory testing** — go off-script, try to break it, find the edges. What happens when someone is sarcastic? Sends a meme? Asks something ambiguous? Says something the agent should ignore?
- **Evaluate personality and voice** — Does it sound human? Does it sound like it belongs in a group chat? Can you tell it's AI? Flag every response that feels robotic, too eager, too formal, or too chatty
- **Test routing logic** — When should the agent speak vs. stay silent? This is the hardest problem. You'll help us map the boundary between "normal friend conversation" (silence) and "actionable travel intent" (respond)
- **Test the intelligence layer** — Vote-on-behalf (does it infer the right preferences?), memory (does it remember what you told it?), recommendations (are they relevant?)
- **Document everything** — Check off success criteria, file bugs in ClickUp and GitHub Issues, write clear repro steps, attach screenshots and conversation transcripts

### What Success Looks Like

- All documented success criteria verified with pass/fail and evidence
- A library of conversation transcripts covering edge cases, failure modes, and personality evaluation
- Bug tickets with clear repro steps for every issue found
- An informed opinion on where the agent feels human and where it doesn't — and why

### Requirements

**Must have:**

- **Native English speaker** — You're judging whether an AI sounds like a real person in a group chat. This requires native-level fluency and cultural instinct for how people actually text
- **Experience with AI-based messaging or chat systems** — You've tested, trained, evaluated, or QA'd conversational AI agents before. Ideally you've helped make an agent sound more human
- **iOS / iPhone testing experience** — iMessage is the primary channel. You need to be comfortable with Apple devices and ideally have experience with multi-device simulation (BrowserStack or similar)
- **Strong QA fundamentals** — You know how to write a bug report, follow a test plan, do exploratory testing, and document findings systematically
- **Attention to conversational nuance** — You notice when a response is one word too long, when punctuation feels off, when the tone shifts from "friend" to "assistant." You have strong opinions about how people actually talk in group chats

**Nice to have:**

- Experience with prompt engineering or LLM evaluation / red-teaming
- Experience with real-time messaging apps (WhatsApp, iMessage, Telegram)
- Familiarity with API testing tools (for understanding what's happening under the hood — no coding required)
- Experience with BrowserStack, Appetize, or similar tools for simulating multiple iOS devices
- Background in linguistics, UX writing, or conversation design
- Experience with ClickUp or GitHub Issues for bug tracking

### Details

- **Type:** Contract, ongoing
- **Hours:** Part-time to start, potentially full-time
- **Start:** ASAP
- **Reports to:** Founder (Jake) and Head of Dev (Asif)
- **Tools we use:** iMessage, ClickUp, GitHub, BrowserStack (or equivalent), TestFlight

### How to Apply

Tell us:

1. Your experience with AI agent testing or evaluation — what did you test, what was the quality bar, and how did you help improve it?
2. Have you ever helped make an AI sound more human? What did you change and why?
3. Send a screenshot of a chatbot interaction (any product) and tell us what's wrong with it — what makes it feel like AI instead of a person?

Short answers preferred. We read every application.
