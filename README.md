**tl;dr** If you look at one thing, see [this movie visualization](http://www.youtube.com/watch?v=cZ4Ntg4jQHw) for a case study on how a post propagates through Quora.

How does information spread through a network? Much of Quora's appeal, after all, lies in its social graph -- and when you've got a network of users, all broadcasting their activities to their neighbors, information can cascade in multiple ways. How do these social designs affect which users see what?

Think, for example, of what happens when your kid learns a new slang word at school. He doesn't confine his use of the word to McKinley Elementary's particular boundaries, between the times of 9-3pm -- he introduces it to his friends from other schools at soccer practice as well. A couple months later, he even says it at home for the first time; you like the word so much, you then start using it at work. Eventually, Justin Bieber uses the word in a song, at which point the word's popularity really starts to explode.

So how does information propagate through a social network? What types of people does an answer on Quora reach, and how does it reach them? (Do users discover new answers individually, or are hubs of connectors more key?) How does the activity of a post on Quora rise and fall? (Submissions on other sites have limited lifetimes, fading into obscurity soon after an initial spike; how does that change when users are connected and every upvote can revive a post for someone else's eyes?)

(I looked at Quora since I had some data from there already available, but I hope the lessons should be fairly applicable in general, to other social networks like Facebook, Twitter, and LinkedIn as well.)

To give an initial answer to some of these questions, I dug into one of my more popular posts, on [a layman's introduction to random forests](http://www.quora.com/Random-Forests/How-do-random-forests-work-in-laymans-terms).

# Users, Topics

Before looking deeper into the voting dynamics of the post, let's first get some background on what kinds of users the answer reached.

Here's a graph of the topics that question upvoters follow. (Each node is a topic, and every time upvoter X follows both topics A and B, I add an edge between A and B.)

[![Upvoters' Topics - Unlabeled](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoter-topics-unlabeled.png)](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoter-topics-unlabeled.png)

[![Upvoters' Topics - Labeled](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoter-topics-labeled.png)](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoter-topics-labeled.png)

We can see from the graph that upvoters tend to be interested in three kinds of topics:

* **Machine learning and other technical matters** (the green cluster): Classification, Data Mining, Big Data, Information Retrieval, Analytics, Probability, Support Vector Machines, R, Data Science, ...
* **Startups/Silicon Valley** (the red cluster): Facebook, Lean Startups, Investing, Seed Funding, Angel Investing, Technology Trends, Product Managment, Silicon Valley Mergers and Acquisitions, Asana, Social Games, Quora, Mark Zuckerberg, User Experience, Founders and Entrepreneurs, ...
* **General Intellectual Topics** (the purple cluster): TED, Science, Book Recommendations, Philosophy, Politics, Self-Improvement, Travel, Life Hacks, ...

Also, here's the network of the upvoters themselves (there's an edge between users A and B if A follows B):

[![Upvote Network - Unlabeled](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoters-unlabeled.png)](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoters-unlabeled.png)

[![Upvote Network - Labeled](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoters-labeled.png)](http://dl.dropbox.com/u/10506/blog/social-network-transmission/rf-upvoters-labeled.png)

We can see three main clusters of users:

* A large group in **green** centered around a lot of power users and Quora employees.
* A machine learning group of folks in **orange** centered around people like Oliver Grisel, Christian Langreiter, and Joseph Turian.
* A group of people following me, in **purple**.
* Plus some smaller clusters in blue and yellow. (There were also a bunch of isolated users, connected to no one, that I filtered out of the picture.)

Digging into how these topic and user graphs are related:

* The orange cluster of users is more heavily into machine learning: 79% of users in that cluster follow more green topics (machine learning and technical topics) than red and purple topics (startups and general intellectual matters). 
* The green cluster of users is reversed: 77% of users follow more of the red and purple clusters of topics (on startups and general intellectual matters) than machine learning and technical topics.

More interestingly, though, we can ask: how do the connections between upvoters relate to the way the post spread?

# Social Voting Dynamics

So let's take a look. Here's a visualization I made of upvotes on my answer across time (click [here](http://www.youtube.com/watch?v=cZ4Ntg4jQHw) for a larger view).

<iframe width="420" height="345" src="http://www.youtube.com/embed/cZ4Ntg4jQHw" frameborder="0" allowfullscreen></iframe>

To represent the social dynamics of these upvotes, I drew an edge from user A to user B if user A transmitted the post to user B through an upvote. (Specifically, I drew an edge from Alice to Bob if Bob follows Alice and Bob's upvote appeared within five days of Alice's upvote; this is meant to simulate the idea that Alice was the key intermediary between my post and Bob.) Also,

* Green nodes are users with at least one upvote edge.
* Blue nodes are users who follow at least one of the topics the post is categorized under (i.e., users who probably discovered the answer by themselves).
* Red nodes are users with no connections and who do not follow any of the post's topics (i.e, users whose path to the post remain mysterious).
* Users increase in size when they produce more connections.

Here's a play-by-play of the video:

* On Feb 14 (the day I wrote the answer), there's a flurry of activity.
* A couple of days later, Tracy Chou gives an upvote, leading to another spike in activity.
* Then all's quiet until... bam! Alex Kamil leads to a surge of upvotes, and his upvote finds Ludi Rehak, who starts a small surge of her own. They're quickly followed by Christian Langreiter, who starts a small revolution among a bunch of machine learning folks a couple days later.
* Then all is pretty calm again, until a couple months later when... bam! Aditya Sengupta brings in a smashing of his own followers, and his upvote makes its way to Marc Bodnick, who sets off a veritable storm of activity.

(Already we can see some relationships between the graph of user connections and the way the post propagated. Many of the users from the orange cluster, for example, come from Alex Kamil and Christian Langreiter's upvotes, and many of the users from the green cluster come from Aditya Sengupta and Marc Bodnick's upvotes. What's interesting, though, is, why didn't the cluster of green users appear all at once, like the orange cluster did? People like Kah Seng Tay, Tracy Chou, Venkatesh Rao, and Chad Little upvoted the answer pretty early on, but it wasn't until Aditya Sengupta's upvote a couple months later that people like Marc Bodnick, Edmond Lau, and many of the other green users (who do indeed follow that first set of folks) discovered the answer. Did the post simply get lost in users' feeds the first time around? Was the post perhaps ignored until it received enough upvotes to be considered worth reading? Are some users' upvotes just trusted more than others'?)

For another view of the upvote dynamics, here's a static visualization, where we can again easily see the clusters of activity:

[![Upvote Temporal Clusters](http://dl.dropbox.com/u/10506/blog/social-network-transmission/upvote-clusters-labeled-v2.png)](http://dl.dropbox.com/u/10506/blog/social-network-transmission/upvote-clusters-labeled-v2.png)

# Fin

There are still many questions I'm hoping to look at; for example,

* What differentiates users who sparked spikes of activity from users who didn't? I don't believe it's simply number of followers, as many well-connected upvoters did *not* lead to cascades of shares. Does authority perhaps matter?
* How far can a post reach? Clearly, the post reached people more than one degree of separation away from me (where one degree of separation is a follower); what does the distribution of degrees look like? Is there any relationship between degree of separation and time of upvote?
* What can we say about the people who started following me after reading my answer? Are they fewer degrees of separation away? Are they more interested in machine learning? Have they upvoted any of my answers before? (Perhaps there's a certain "threshold" of interestingness people need to overflow before they're considered acceptable followees.)

But for now, to summarize a bit what we've found so far, here are some statistics on the role the social graph played in spreading the post:

* There are 5 clusters of activity after the initial post, sparked both by power users and less-connected folks. In an interesting cascade of information, some of these sparks led to further spikes in activity as well (as when Aditya Sengupta's upvote found its way to Marc Bodnick, who set off even more activity).
* 35% of users made their way to my answer because of someone else's upvote.
* Through these connections, the post reached a fair variety of users: 32% of upvoters don't even follow any of the post's topics.
* 77% of upvotes came from users over two weeks *after* my answer appeared. 
* If we look only at the upvoters who follow at least one of the post's topics, 33% didn't see my answer until someone else showed it to them. In other words, a full one-third of people who presumably would have been interested in my post anyways only found it because of their social network.

So it looks like the social graph played quite a large part in the post's propagation, and I'll end with a big shoutout to Stormy Shippy, who provided an awesome set of scripts I used to collect a lot of this data.