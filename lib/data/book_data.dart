import 'package:final_project_haija/models/book.dart';

var bookList = [
  Book(
      title: '12 Rules for Life',
      author: 'Jordan B. Peterson',
      publishedDate: DateTime(2018, 1, 16),
      rating: 3.9,
      description:
      '''What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research.

                    Humorous, surprising, and informative, Dr. Peterson tells us why skateboarding boys and girls must be left alone, what terrible fate awaits those who criticize too easily, and why you should always pet a cat when you meet one on the street.

                    What does the nervous system of the lowly lobster have to tell us about standing up straight (with our shoulders back) and about success in life? Why did ancient Egyptians worship the capacity to pay careful attention as the highest of gods? What dreadful paths do people tread when they become resentful, arrogant, and vengeful? Dr. Peterson journeys broadly, discussing discipline, freedom, adventure, and responsibility, distilling the world's wisdom into 12 practical and profound rules for life. 12 Rules for Life shatters the modern commonplaces of science, faith, and human nature while transforming and ennobling the mind and spirit of its listeners.''',
      genre: [
        'Nonfiction',
        'Psychology',
        'Self Help',
        'Philosophy',
        'Personal Development'
      ],
      imageAsset:
      'https://cdn.gramedia.com/uploads/items/9780735278516_12-Rules-For-Life-An-Antidote-To-Chaos.jpg',
      isFavorite: false),
  Book(
      title: 'Beyond Order: 12 More Rules for Life',
      author: 'Jordan B. Peterson',
      publishedDate: DateTime(2021, 3, 2),
      rating: 4.1,
      description: '''
      The sequel to 12 Rules for Life offers further guidance on the periolus path of modern life.

In 12 Rules for Life, clinical psychologist and celebrated professor at Harvard and the University of Toronto Dr. Jordan B. Peterson helped millions of readers impose order on the chaos of their lives. Now, in this bold sequel, Peterson delivers twelve more lifesaving principles for resisting the exhausting toll that our desire to order the world inevitably takes.

In a time when the human will increasingly imposes itself over every sphere of life—from our social structures to our emotional states—Peterson warns that too much security is dangerous. What’s more, he offers strategies for overcoming the cultural, scientific, and psychological forces causing us to tend toward tyranny, and teaches us how to rely instead on our instinct to find meaning and purpose, even—and especially—when we find ourselves powerless.

While chaos, in excess, threatens us with instability and anxiety, unchecked order can petrify us into submission. Beyond Order provides a call to balance these two fundamental principles of reality itself, and guides us along the straight and narrow path that divides them.
''',
      genre: [
        'Nonfiction',
        'Psychology',
        'Self Help',
        'Philosophy',
        'Personal Development'
      ],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1675973189i/56019043.jpg',
      isFavorite: false),
  Book(
      title: 'Harry Potter and the Sorcerer’s Stone',
      author: 'J.K. Rowling',
      publishedDate: DateTime(1997, 6, 26),
      rating: 4.4,
      description: '''
      "Turning the envelope over, his hand trembling, Harry saw a purple wax seal bearing a coat of arms; a lion, an eagle, a badger and a snake surrounding a large letter 'H'."

Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harry's eleventh birthday, a great beetle-eyed giant of a man called Rubeus Hagrid bursts in with some astonishing news: Harry Potter is a wizard, and he has a place at Hogwarts School of Witchcraft and Wizardry. An incredible adventure is about to begin!
''',
      genre: ['Fiction', 'Young Adult', 'Magic', 'Children', 'Middle Grade'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1598823299i/42844155.jpg',
      isFavorite: false),
  Book(
      title: 'Harry Potter and the Chamber of Secrets',
      author: 'J.K. Rowling',
      publishedDate: DateTime(1998, 7, 2),
      rating: 4.4,
      description: '''
      Ever since Harry Potter had come home for the summer, the Dursleys had been so mean and hideous that all Harry wanted was to get back to the Hogwarts School for Witchcraft and Wizardry. But just as he’s packing his bags, Harry receives a warning from a strange impish creature who says that if Harry returns to Hogwarts, disaster will strike.

And strike it does. For in Harry’s second year at Hogwarts, fresh torments and horrors arise, including an outrageously stuck-up new professor and a spirit who haunts the girls’ bathroom. But then the real trouble begins – someone is turning Hogwarts students to stone. Could it be Draco Malfoy, a more poisonous rival than ever? Could it possibly be Hagrid, whose mysterious past is finally told? Or could it be the one everyone at Hogwarts most suspects… Harry Potter himself!
      ''',
      genre: ['Fantasy', 'Fiction', 'Young Adult', 'Magic', 'Children'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1474169725i/15881.jpg',
      isFavorite: false),
  Book(
      title: 'Harry Potter and the Prisoner of Azkaban',
      author: 'J.K. Rowling',
      publishedDate: DateTime(1999, 7, 8),
      rating: 4.5,
      description: '''
      Harry Potter, along with his best friends, Ron and Hermione, is about to start his third year at Hogwarts School of Witchcraft and Wizardry. Harry can't wait to get back to school after the summer holidays. (Who wouldn't if they lived with the horrible Dursleys?) But when Harry gets to Hogwarts, the atmosphere is tense. There's an escaped mass murderer on the loose, and the sinister prison guards of Azkaban have been called in to guard the school...
      ''',
      genre: ['Fantasy', 'Fiction', 'Young Adult', 'Magic', 'Children'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1630547330i/5.jpg',
      isFavorite: false),
  Book(
      title: 'Harry Potter and the Goblet of Fire',
      author: 'J.K. Rowling',
      publishedDate: DateTime(2000, 7, 8),
      rating: 4.5,
      description: '''
      It is the summer holidays and soon Harry Potter will be starting his fourth year at Hogwarts School of Witchcraft and Wizardry. Harry is counting the days: there are new spells to be learnt, more Quidditch to be played, and Hogwarts castle to continue exploring. But Harry needs to be careful - there are unexpected dangers lurking...
      ''',
      genre: ['Fantasy', 'Fiction', 'Young Adult', 'Magic', 'Children'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1554006152i/6.jpg',
      isFavorite: false),
  Book(
      title: 'Harry Potter and the Order of the Phoenix',
      author: 'J.K. Rowling',
      publishedDate: DateTime(2003, 6, 21),
      rating: 4.5,
      description: '''
      Harry Potter is about to start his fifth year at Hogwarts School of Witchcraft and Wizardry. Unlike most schoolboys, Harry never enjoys his summer holidays, but this summer is even worse than usual. The Dursleys, of course, are making his life a misery, but even his best friends, Ron and Hermione, seem to be neglecting him.

Harry has had enough. He is beginning to think he must do something, anything, to change his situation, when the summer holidays come to an end in a very dramatic fashion. What Harry is about to discover in his new year at Hogwarts will turn his world upside down...
      ''',
      genre: ['Fantasy', 'Fiction', 'Young Adult', 'Magic', 'Children'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1546910265i/2.jpg',
      isFavorite: false),
  Book(
      title: 'Harry Potter and the Half-Blood Prince',
      author: 'J.K. Rowling',
      publishedDate: DateTime(2005, 7, 16),
      rating: 4.5,
      description: '''
      It is the middle of the summer, but there is an unseasonal mist pressing against the windowpanes. Harry Potter is waiting nervously in his bedroom at the Dursleys' house in Privet Drive for a visit from Professor Dumbledore himself. One of the last times he saw the Headmaster, he was in a fierce one-to-one duel with Lord Voldemort, and Harry can't quite believe that Professor Dumbledore will actually appear at the Dursleys' of all places. Why is the Professor coming to visit him now? What is it that cannot wait until Harry returns to Hogwarts in a few weeks' time? Harry's sixth year at Hogwarts has already got off to an unusual start, as the worlds of Muggle and magic start to intertwine...
      ''',
      genre: ['Fantasy', 'Fiction', 'Young Adult', 'Magic', 'Children'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1587697303i/1.jpg',
      isFavorite: false),
  Book(
      title: 'Harry Potter and the Deathly Hallows',
      author: 'J.K. Rowling',
      publishedDate: DateTime(2007, 7, 21),
      rating: 4.6,
      description: '''
      Harry has been burdened with a dark, dangerous and seemingly impossible task: that of locating and destroying Voldemort's remaining Horcruxes. Never has Harry felt so alone, or faced a future so full of shadows. But Harry must somehow find within himself the strength to complete the task he has been given. He must leave the warmth, safety and companionship of The Burrow and follow without fear or hesitation the inexorable path laid out for him...

In this final, seventh installment of the Harry Potter series, J.K. Rowling unveils in spectacular fashion the answers to the many questions that have been so eagerly awaited.
      ''',
      genre: ['Fantasy', 'Fiction', 'Young Adult', 'Magic', 'Children'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1663805647i/136251.jpg',
      isFavorite: false),
  Book(
      title: 'House of Flame and Shadow',
      author: 'Sarah J. Maas',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      The stunning third book in the sexy, action-packed Crescent City series, following the global bestsellers House of Earth and Blood and House of Sky and Breath.

Bryce Quinlan never expected to see a world other than Midgard, but now that she has, all she wants is to get back. Everything she loves is in Midgard: her family, her friends, her mate. Stranded in a strange new world, she's going to need all her wits about her to get home again. And that's no easy feat when she has no idea who to trust.

Hunt Athalar has found himself in some deep holes in his life, but this one might be the deepest of all. After a few brief months with everything he ever wanted, he's in the Asteri's dungeons again, stripped of his freedom and without a clue as to Bryce's fate. He's desperate to help her, but until he can escape the Asteri's leash, his hands are quite literally tied.

In this sexy, breathtaking sequel to the #1 bestsellers House of Earth and Blood and House of Sky and Breath, Sarah J. Maas's Crescent City series reaches new heights as Bryce and Hunt's world is brought to the brink of collapse-with its future resting on their shoulders.
      ''',
      genre: ['Fantasy', 'Fiction', 'Adult', 'Romance', 'Urban Fantasy'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1689809645i/52857700.jpg',
      isFavorite: false),
  Book(
      title: 'Everything Is Temporary',
      author: 'Jon Cohn',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
How well do we really know the people sleeping next to us in bed at night?

After a tragedy strikes the Barnes family, Sarah's husband Tom begins acting strangely. It starts with wild mood-shifts and accusations at their thirteen-year old daughter, but quickly escalates to the attempted murder of an off-season mall Santa. From what Sarah can tell, Tom's only motive seems to lie behind a mysterious hatred for Christmas that burns year round. What's worse, Tom's only defense lies in a long-forgotten book he wrote detailing a traumatic event in his childhood that seems too far-fetched to be believed. His entire case revolves around the notion of talking Christmas trees, a living army of toys, and worst of all, a monster masquerading as Mrs. Claus.

Now, Sarah must go on a journey into her husband's past to learn if Tom is in the midst of a psychotic breakdown, if he's a danger to his family, or if he really is being hunted by the malevolent holiday horror that destroyed his childhood.
      ''',
      genre: ['Horror', 'Christmas', 'Mystery', 'Holiday', 'Thriller'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1693420601i/198270623.jpg',
      isFavorite: false),
  Book(
      title: 'Mothtown',
      author: 'Caroline Hardaker',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      David is growing up in a world where something is very badly wrong but everyone is protecting David from knowing what it is. People are going missing, bodies are showing up with wings, or bones in nests if you believe the rumours from the kids at school. David doesn’t really know because his parents turn off the news whenever he might get a handle on what is happening around him and his older sister just doesn’t seem interested in sharing.

Most importantly for David the centre of his world – his grandfather – is gone. His parents say he is dead but why is his grandfather’s backpack and jumper missing from the house? Alongside this we have a man abandoned in a hostile landscape and trying out run nature itself to get back home with some information.
      ''',
      genre: ['Horror', 'Fantasy', 'Fiction', 'Adult', 'Science Fiction'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1684797278i/80328993.jpg',
      isFavorite: false),
  Book(
      title: 'Beholder',
      author: 'Ryan La Sala',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      "Beholder is a resplendent monster of power, secrets, wealth, and murderous interior design." - Andrew Joseph White, New York Times bestselling author of Hell Followed With Us

"A top-notch horror novel." - Publishers Weekly Starred Review

"Ryan La Sala is one of the most exciting, risk-taking authors working in YA. BEHOLDER is, like THE HONEYS, a high-wire act of brilliant invention.” - Melissa Albert, bestselling author of The Hazel Wood

"This berserk beauty is a joy to behold! - Adam Sass, award-winning author of Surrender Your Sons and Your Lonely Nights Are Over

From Ryan La Sala, author of the tantalizingly twisted The Honeys and riotously imaginative Reverie, comes a chilling new contemporary fable about art, aesthetic obsession, and the gaze that peers back at us from behind our reflections.

Athanasios “Athan” Bakirtzis hasn’t had an easy life. Orphaned by a fire at a young age, he’s had to rely on his charm, his under-the-table job as an art handler, and the generosity of family friends to care for his ailing Yiayia, his grandmother.

But Athan also has a secret: a hereditary power that allows him to rewind the reflection in any mirror, peering into its recent past. Superstitious Yiayia calls the family ability a curse, and has long warned him never to use it. For Athan, who’s survived this long by keeping to the realm of the real, this is a perfectly agreeable arrangement.

Until the night of the party. After being invited to a penthouse soiree for New York’s art elite, Athan breaks his grandmother’s rule during a trip to the bathroom, turning back his reflection for just a moment. Then he hears a slam against the bathroom door, followed by a scream. Athan peers outside, only to be pushed back in by a boy his age. The boy gravely tells him not to open the door, then closes Athan in.

Before Athan can process what’s happening, more screams follow, and the party descends into chaos. When he finally emerges, he discovers a massacre where the victims appear to have arranged themselves into a disturbingly elegant sculpture—and Athan's mysterious savior is nowhere to be found.

Something evil is compelling people to destructive acts, a presence that’s been hiding behind Athan’s reflection his whole life, watching and biding its time. Soon, he’s swept up in a supernatural conspiracy that spans New York, of occult high societies and deadly eldritch designs. If beauty really is in the eye of the beholder, what can it do to us once it’s inside?
      ''',
      genre: ['Horror', 'Fantasy', 'Mystery', 'Fiction', 'Queer'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1675956367i/61779957.jpg',
      isFavorite: false),
  Book(
      title: 'Artifice',
      author: 'Sharon Cameron',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      A dramatic story of duplicity and resistance, betrayal and loyalty, set against the backdrop of World War II, by the #1 New York Times bestselling author of The Light in Hidden Places.

Isa de Smit was raised in the vibrant, glittering world of her parents' small art gallery in Amsterdam, a hub of beauty, creativity, and expression, until the Nazi occupation wiped the color from her city's palette.
The "degenerate" art of the Gallery de Smit is confiscated, the artists in hiding or deported, her best friend, Truus, fled to join the shadowy Dutch resistance.
And masterpiece by masterpiece, the Nazis are buying and stealing her country’s heritage, feeding the Third Reich's ravenous appetite for culture and art.

So when the unpaid taxes threaten her beloved but empty gallery, Isa decides to make the Nazis pay. She sells them a fake--a Rembrandt copy drawn by her talented father--a sale that sets Isa perilously close to the second-most hated class of people in the city: the collaborators.

Isa sells her beautiful forgery to none other than Hitler himself, and on the way to the auction, discovers that Truus is part of a resistance ring to smuggle Jewish babies out of Amsterdam.
But Truus cannot save more children without money. A lot of money. And Isa thinks she knows how to get it.

One more forgery, a copy of an exquisite Vermeer, and the Nazis will pay for the rescue of the very children they are trying annihilate. To make the sale, though, Isa will need to learn the art of a master forger, before the children can be deported, and before she can be outed as a collaborator.
And she finds an unlikely source to help her - the young Nazi soldier, a blackmailer and thief of Dutch art, who now says he wants to desert the German army.
Yet, worth is not always seen from the surface, and a fake can be difficult to spot. Both in art, and in people.

Based on the true stories of Han Van Meegeren, a master art forger who sold fakes to Hermann Goering, and Johann van Hulst, credited with saving 600 Jewish children from death in Amsterdam, Sharon Cameron weaves a gorgeously evocative thriller, simmering with twists, that looks for the forgotten color of beauty, even in an ugly world.

"War, resistance, and art are Cameron's canvas; her palette is a balance of trust and perfidy, beauty and defiance, new life and old. Artifice is a vibrantly-hued and many-layered story, exploring our very human inability to spot a fake when we long to believe that the object of all our desire is the real thing." -- Elizabeth Wein, New York Times bestselling author of Code Name Verity

"Painterly prose...filled with rich intrigue depicts constantly shifting issues of trust in this complex, absorbing tale." -- Publishers Weekly, starred review
      ''',
      genre: ['Historical', 'War', 'Fiction', 'Art', 'Young Adult'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1680320063i/63899000.jpg',
      isFavorite: false),
  Book(
      title: 'What Tou Do to Me',
      author: 'Rochelle B. Weinstein',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      From the bestselling author of This Is Not How It Ends comes a moving novel of two unfinished love stories and the music and lyrics that bring them together.

Journalist Cecilia James is a sucker for a love song. So when she stumbles across a clue to the identity of the muse for one of rock’s greatest, she devotes herself to uncovering the truth, even as her own relationship is falling apart.
      ''',
      genre: ['Romance', 'Fiction', 'Music', 'Family', 'Audiobook'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1689190369i/63852945.jpg',
      isFavorite: false),
  Book(
      title:
      'String Theories: Tips, Challenges, and Reflections for the Lifelong Guitarist',
      author: 'Adam Levy, Ethan Sherman',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      In String Theories, renowned guitarists Adam Levy and Ethan Sherman offer a comprehensive and practical guide to boundless musical growth for the dedicated guitarist, as well as on-the-job lessons learned from both of their many years of experience as players and teachers.

Originally adapted from Adam Levy’s popular YouTube series Guitar Tips, the essays and lessons in String Theories cover topics including effective practice strategies, fretboard technique, playing with other musicians, composition, improvisation, listening and reading recommendations, and more. Concepts are followed by practical exercises and plans of action—things you can do today, throughout the week or month, or even all year.

String Theories offers something different yet equally useful to the student, hobbyist, or pro—and everyone in between. With a framework for lifelong growth on the guitar, it’s a book you can return to year after year as you evolve as a musician.
      ''',
      genre: ['Music'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1696525434i/199289673.jpg',
      isFavorite: false),
  Book(
      title:
      'Blood Memory: The Tragic Decline and Improbable Resurrection of the American Buffalo',
      author: 'Dayton Duncan, Ken Burns',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      The epic story of the buffalo in America, from prehistoric times to today—a moving and beautifully illustrated work of natural history

The American buffalo—our nation’s official mammal—is an improbable, shaggy beast that has found itself at the center of many of our most mythic and sometimes heartbreaking tales. The largest land animals in the Western Hemisphere, they are survivors of a mass extinction that erased ancient species that were even larger. For nearly 10,000 years, they evolved alongside Native people who weaved them into every aspect of daily life; relied on them for food, clothing, and shelter; and revered them as equals.

Newcomers to the continent found the buffalo fascinating at first, but in time they came to consider them a hindrance to a young nation’s expansion. And in the space of only a decade, they were slaughtered by the millions for their hides, with their carcasses left to rot on the prairies. Then, teetering on the brink of disappearing from the face of the earth, they would be rescued by a motley collection of Americans, each of them driven by different—and sometimes competing—impulses. This is the rich and complicated story of a young republic's heedless rush to conquer a continent, but also of the dawn of the conservation era—a story of America at its very best and worst.
      ''',
      genre: ['Nonfiction', 'History', 'Animals', 'Nature', 'Science'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1682566084i/142392370.jpg',
      isFavorite: false),
  Book(
      title:
      'Lay Them to Rest: On the Road with the Cold Case Investigators Who Identify the Nameless',
      author: 'Laurah Norton',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      A fascinating deep dive into the dark world of forensic science as experts team up to solve the identity of an unknown woman named "Ina Jane Doe," exploring the rapidly evolving techniques scientists are using to break the most notorious cold cases, written by the host of the popular true crime podcast, The Fall Line

Fans of true crime shows like CSI, NCIS, Criminal Minds, and Law and Order know that when it comes to "getting the bad guy" behind bars, your best chance of success boils down to the strength of your evidence--and the forensic science used to obtain it. Beyond the silver screen, forensic science has been used for decades to help solve even the most tough-to-crack cases. In 2018, the accused Golden State Killer, Joseph DeAngelo, was finally apprehended after a decades-long investigation thanks to a very recent technique called forensic genealogy, which has since led to the closure of hundreds of cold cases, bringing long-awaited justice to victims and families alike. But when it comes to solving these incredibly difficult cases, forensic genealogy is just the tip of the iceberg--and many readers have no idea just how far down that iceberg goes.

For Laurah Norton, forensic science was always more of a passion than anything else. But after learning about a mishandled 1990s cold case involving missing twins, she was spurred to action, eventually creating a massively popular podcast and building a platform that helped bring widespread attention and resources to the case. LAY THEM TO REST builds on Laurah's fascination with these investigations, introducing readers to the history and evolution of forensic science, from the death masks used in Ancient Rome to the 3-D facial reconstruction technology used today. Incorporating the stories of real-life John & Jane Does from around the world, Laurah also examines how changing identification methods have helped solve the most iconic cold cases. Along the way readers will also get to see Laurah solve a case in real time with forensic anthropologist Dr. Amy Michael, as they try to determine the identity of "Ina" Jane Doe, a woman whose head was found in a brush in an Illinois park in 1993.

More than just a chronicle of the history of forensics, LAY THEM TO REST is also a celebration of the growing field of experts, forensic artists, and anthropologists (many of whom Laurah talks to in the book), who work tirelessly to bring closure to these unsolved cases. And of course, this book asks why some cases go unsolved, highlighting the "missing missing," the sex workers, undocumented, the cases that so desperately need our attention, but so rarely get it.

Engrossing, informative, heartbreaking, and hopeful, LAY THEM TO REST is a deep dive into the world of forensic science, showing readers how far we've come in cracking cases and catching killers, and illuminating just how far we have yet to go.
      ''',
      genre: ['Nonfiction', 'Science', 'Crime', 'Mystery', 'Audiobook'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1676842634i/103450619.jpg',
      isFavorite: false),
  Book(
      title: 'A Demon\'s Guide to Woong a Witch',
      author: 'Sarah Hawley',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      Calladia Cunnington curses the day she met Astaroth the demon, but when he shows up memoryless, why does she find him so helpless . . . and sort of hot?

Calladia Cunnington knows she's rough around the edges, despite being the heir to one of small-town Glimmer Falls' founding witch families. While her gym obsession is a great outlet for her anxieties and anger, her hot temper still gets the best of her and manifests in bar brawls. When Calladia saves someone from a demon attack one night, though, she's happy to put her magic and rage to good use . . . until she realizes the man she saved is none other than Astaroth, the ruthless demon who orchestrated a soul bargain on her best friend.

Astaroth is a legendary soul bargainer and one of the nine members of the demon high council--except he can't remember any of this. Suffering from amnesia after being banished to the mortal plane, Astaroth doesn't know why a demon named Moloch is after him, nor why the muscular, angry, hot-in-a-terrifying-way witch who saved him hates him so much.

Unable to leave anyone in such a vulnerable state--even the most despicable demon--Calladia grudgingly decides to help him. (Besides, punching an amnesiac would be in poor taste.) The two set out on an uneasy road trip to find the witch who might be able to restore Astaroth's memory so they can learn how to defeat Moloch. Calladia vows that once Astaroth is cured, she'll kick his ass, but the more time she spends with the snarky yet utterly charming demon, the more she realizes she likes this new, improved Astaroth . . . and maybe she doesn't want him to recover his memories, after all.
      ''',
      genre: ['Romance', 'Fnatasy', 'Paranormal', 'Adult', 'Witches'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1681323106i/123201433.jpg',
      isFavorite: false),
  Book(
      title: 'Love Redesigned',
      author: 'Lauren Asher',
      publishedDate: DateTime(2024, 7, 21),
      rating: null,
      description: '''
      Julian
If I ever caught on fire, Dahlia Muñoz would fan the flames with a smile.
So, when she returns to Lake Wisteria, I fully intend to avoid the interior designer.
At least until my meddling mother exploits my savior complex.
The faster I help Dahlia find her creative spark, the sooner she will leave town.
But while I was busy getting rid of Dahlia, I overlooked one potential issue.
What happens if I want her to stay?

Dahlia
People say the devil has many faces, but I know only one.
Julian Lopez—my childhood rival and family frenemy.
I vow to steer clear of him while recovering from my broken engagement, but then the billionaire makes an irresistible offer.
Renovate a historic house together and triple our profits.
Our temporary truce becomes compromised as we face years’ worth of denied attraction and mixed emotions.
Giving into our desire is inevitable…but falling in love?
That isn’t part of the plan.

Love Redesigned is a steamy, small town romance about two family friends-turned-childhood rivals. It is the first book in the standalone Lakefront Billionaires series and has a happy ending.
      ''',
      genre: ['Romance', 'Adult', 'Fiction', 'Audiobook'],
      imageAsset: 'https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/A1GqbH4RpyL._AC_UF894,1000_QL80_.jpg',
      isFavorite: false),
  Book(
      title: 'The Hunger Games',
      author: 'Suzanne Collins',
      publishedDate: DateTime(2008, 9, 14),
      rating: 4.3,
      description: '''
    Could you survive on your own in the wild, with every one out to make sure you don't live to see the morning?

In the ruins of a place once known as North America lies the nation of Panem, a shining Capitol surrounded by twelve outlying districts. The Capitol is harsh and cruel and keeps the districts in line by forcing them all to send one boy and one girl between the ages of twelve and eighteen to participate in the annual Hunger Games, a fight to the death on live TV.

Sixteen-year-old Katniss Everdeen, who lives alone with her mother and younger sister, regards it as a death sentence when she steps forward to take her sister's place in the Games. But Katniss has been close to dead before—and survival, for her, is second nature. Without really meaning to, she becomes a contender. But if she is to win, she will have to start making choices that weight survival against humanity and life against love.''',
      genre: ['Fiction', 'Fantasy', 'Science Fiction', 'Adventure', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1586722975i/2767052.jpg',
      isFavorite: false),
  Book(
      title: 'Catching Fire',
      author: 'Suzanne Collins',
      publishedDate: DateTime(2009, 9, 1),
      rating: 4.3,
      description: '''Sparks are igniting.
Flames are spreading.
And the Capitol wants revenge.

Against all odds, Katniss Everdeen has won the Hunger Games. She and fellow District 12 tribute Peeta Mellark are miraculously still alive. Katniss should be relieved, happy even. After all, she has returned to her family and her longtime friend, Gale. Yet nothing is the way Katniss wishes it to be. Gale holds her at an icy distance. Peeta has turned his back on her completely. And there are whispers of a rebellion against the Capitol—a rebellion that Katniss and Peeta may have helped create.

Much to her shock, Katniss has fueled an unrest that she's afraid she cannot stop. And what scares her even more is that she's not entirely convinced she should try. As time draws near for Katniss and Peeta to visit the districts on the Capitol's cruel Victory Tour, the stakes are higher than ever. If they can't prove, without a shadow of a doubt, that they are lost in their love for each other, the consequences will be horrifying.

In Catching Fire, the second novel of the Hunger Games trilogy, Suzanne Collins continues the story of Katniss Everdeen, testing her more than ever before . . . and surprising readers at every turn.''',
      genre: ['Fiction', 'Fantasy', 'Science Fiction', 'Adventure', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1586722941i/6148028.jpg',
      isFavorite: false),
  Book(
      title: 'Mockingjay',
      author: 'Suzanne Collins',
      publishedDate: DateTime(2010, 8, 24),
      rating: 4.0,
      description: '''My name is Katniss Everdeen.
Why am I not dead?
I should be dead.

Katniss Everdeen, girl on fire, has survived, even though her home has been destroyed. Gale has escaped. Katniss's family is safe. Peeta has been captured by the Capitol. District 13 really does exist. There are rebels. There are new leaders. A revolution is unfolding.

It is by design that Katniss was rescued from the arena in the cruel and haunting Quarter Quell, and it is by design that she has long been part of the revolution without knowing it. District 13 has come out of the shadows and is plotting to overthrow the Capitol. Everyone, it seems, has had a hand in the carefully laid plans—except Katniss.

The success of the rebellion hinges on Katniss's willingness to be a pawn, to accept responsibility for countless lives, and to change the course of the future of Panem. To do this, she must put aside her feelings of anger and distrust. She must become the rebels' Mockingjay—no matter what the personal cost.''',
      genre: ['Fiction', 'Fantasy', 'Science Fiction', 'Adventure', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1586722941i/6148028.jpg',
      isFavorite: false),
  Book(
      title: 'Twilight',
      author: 'Stephenie Meyer',
      publishedDate: DateTime(2005, 10, 5),
      rating: 3.6,
      description: '''About three things I was absolutely positive.

First, Edward was a vampire.

Second, there was a part of him - and I didn't know how dominant that part might be - that thirsted for my blood.

And third, I was unconditionally and irrevocably in love with him.

Deeply seductive and extraordinarily suspenseful, Twilight is a love story with bite.''',
      genre: ['Fiction', 'Fantasy', 'Supernatural', 'Vampires', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1700522826i/41865.jpg',
      isFavorite: false),
  Book(
      title: 'New Moon',
      author: 'Stephenie Meyer',
      publishedDate: DateTime(2006, 9, 6),
      rating: 3.5,
      description:
      '''There is an alternate cover edition for ISBN13 9780316160193 here.

I knew we were both in mortal danger. Still, in that instant, I felt well. Whole. I could feel my heart racing in my chest, the blood pulsing hot and fast through my veins again. My lungs filled deep with the sweet scent that came off his skin. It was like there had never been any hole in my chest. I was perfect - not healed, but as if there had never been a wound in the first place.

I FELT LIKE I WAS TRAPPED IN ONE OF THOSE TERRIFYING NIGHTMARES, the one where you have to run, run till your lungs burst, but you can't make your body move fast enough.... But this was no dream, and, unlike the nightmare, I wasn't running for my life; I was racing to save something infinitely more precious. My own life meant little to me today.

FOR BELLA SWAN THERE IS ONE THING more important than life itself: Edward Cullen. But being in love with a vampire is even more dangerous than Bella could ever have imagined. Edward has already rescued Bella from the clutches of one evil vampire, but now, as their daring relationship threatens all that is near and dear to them, they realize their troubles may be just beginning....

LEGIONS OF READERS ENTRANCED BY THE New York Times bestseller Twilight are hungry for the continuing story of star-crossed lovers Bell and Edward. In New Moon, Stephanie Meyer delivers another irresistible combination of romance and suspense with a supernatural spin. passionate, riveting, and full of surprising twists and turns, this vampire love saga is well on its way to literary immortality.''',
      genre: ['Fiction', 'Fantasy', 'Supernatural', 'Vampires', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1630592760i/49041.jpg',
      isFavorite: false),
  Book(
      title: 'Eclipse',
      author: 'Stephenie Meyer',
      publishedDate: DateTime(2007, 8, 7),
      rating: 3.7,
      description: '''"BELLA?"
Edward's soft voice came from behind me. I turned to see him spring lightly up the porch steps, his hair windblown from running. He pulled me into his arms at once, just like he had in the parking lot, and kissed me again.
This kiss frightened me. There was too much tension, too strong an edge to the way his lips crushed mine - like he was afraid we had only so much time left to us.
''',
      genre: ['Fiction', 'Fantasy', 'Supernatural', 'Vampires', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1361038355i/428263.jpg',
      isFavorite: false),
  Book(
      title: 'Breaking Dawn',
      author: 'Stephenie Meyer',
      publishedDate: DateTime(2008, 8, 2),
      rating: 3.7,
      description: '''"Don't be afraid," I murmured. "We belong together."
I was abruptly overwhelmed by the truth of my own words.
This moment was so perfect, so right, there was no way to doubt it.
His arms wrapped around me,
holding me against him....
It felt like every nerve ending in my body was a live wire.
"Forever," he agreed.

WHEN YOU LOVED THE ONE WHO WAS KILLING YOU, IT LEFT YOU NO OPTIONS. How could you run, how could you fight, when doing so would hurt that beloved one? If your life was all you had to give, how could you not give it? If it was someone you truly loved?

TO BE IRREVOCABLY IN LOVE WITH A VAMPIRE is both fantasy and nightmare woven into a dangerously heightened reality for Bella Swan. Pulled in one direction by her intense passion for Edward Cullen, and in another by her profound connection to werewolf Jacob Black, a tumultuous year of temptation, loss, and strife have led her to the ultimate turning point. Her imminent choice to either join the dark but seductive world of immortals or to pursue a fully human life has become the thread from which the fates of two tribes hangs.

NOW THAT BELLA HAS MADE HER DECISION, a startling chain of unprecedented events is about to unfold with potentially devastating, and unfathomable, consequences. Just when the frayed strands of Bella's life - first discovered in Twilight, then scattered and torn in New Moon and Eclipse - seem ready to heal and knit together, could they be destroyed... forever?

THE ASTONISHING, BREATHLESSLY anticipated conclusion to the Twilight Saga, Breaking Dawn illuminates the secrets and mysteries of this spellbinding romantic epic that has entranced millions.''',
      genre: ['Fiction', 'Fantasy', 'Supernatural', 'Vampires', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1361039438i/1162543.jpg',
      isFavorite: false),
  Book(
      title: 'Midnight Sun',
      author: 'Stephenie Meyer',
      publishedDate: DateTime(2020, 8, 4),
      rating: 3.7,
      description:
      '''When Edward Cullen and Bella Swan met in Twilight, an iconic love story was born. But until now, fans have heard only Bella's side of the story. At last, readers can experience Edward's version in the long-awaited companion novel, Midnight Sun.

This unforgettable tale as told through Edward's eyes takes on a new and decidedly dark twist. Meeting Bella is both the most unnerving and intriguing event he has experienced in all his years as a vampire. As we learn more fascinating details about Edward's past and the complexity of his inner thoughts, we understand why this is the defining struggle of his life. How can he justify following his heart if it means leading Bella into danger?''',
      genre: ['Fiction', 'Fantasy', 'Supernatural', 'Vampires', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1588597375i/53287484.jpg',
      isFavorite: false),
  Book(
      title: 'It',
      author: 'Stephen King',
      publishedDate: DateTime(1986, 9, 15),
      rating: 4.2,
      description: '''Welcome to Derry, Maine ...

It’s a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real ...

They were seven teenagers when they first stumbled upon the horror. Now they are grown-up men and women who have gone out into the big world to gain success and happiness. But none of them can withstand the force that has drawn them back to Derry to face the nightmare without an end, and the evil without a name.''',
      genre: ['Fiction', 'Fantasy', 'Supernatural', 'Horror', 'Thriller'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1334416842i/830502.jpg',
      isFavorite: false),
  Book(
      title: 'The Mummy',
      author: 'Anne Rice',
      publishedDate: DateTime(1989, 1, 1),
      rating: 3.8,
      description:
      '''Ramses the Great has reawakened in opulent Edwardian London. Having drunk the elixir of life, he is now Ramses the Damned, doomed forever to wander the earth, desperate to quell hungers that can never be satisfied. He becomes the close companion of a voluptuous heiress, Julie Stratford, but his cursed past again propels him toward disaster. He is tormented by searing memories of his last reawakening, at the behest of Cleopatra, his beloved queen of Egypt. And his intense longing for her, undiminished over the centuries, will force him to commit an act that will place everyone around him in the gravest danger.''',
      genre: ['Fiction', 'Fantasy', 'Supernatural', 'Horror', 'Romance'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1347523787i/43782.jpg',
      isFavorite: false),
  Book(
      title: 'Memoirs of a Geisha',
      author: 'Arthur Golden',
      publishedDate: DateTime(1997, 1, 1),
      rating: 3.9,
      description:
      '''A literary sensation and runaway bestseller, this brilliant novel presents with seamless authenticity and exquisite lyricism the true confessions of one of Japan's most celebrated geisha.

In "Memoirs of a Geisha," we enter a world where appearances are paramount; where a girl's virginity is auctioned to the highest bidder; where women are trained to beguile the most powerful men; and where love is scorned as illusion. It is a unique and triumphant work of fiction - at once romantic, erotic, suspenseful - and completely unforgettable.
''',
      genre: ['Fiction', 'HistoricalFiction', 'Romance', 'Classics', 'Japan'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1409595968i/929.jpg',
      isFavorite: false),
  Book(
      title: 'Good Girls Don\'t Die',
      author: 'Christina Henry',
      publishedDate: DateTime(2023, 11, 14),
      rating: 3.58,
      description:
      '''A sharp-edged, supremely twisty thriller about three women who find themselves trapped inside stories they know aren’t their own, from the author of Alice and Near the Bone.

Celia wakes up in a house that’s supposed to be hers. There’s a little girl who claims to be her daughter and a man who claims to be her husband, but Celia knows this family—and this life—is not hers…

Allie is supposed to be on a fun weekend trip—but then her friend’s boyfriend unexpectedly invites the group to a remote cabin in the woods. No one else believes Allie, but she is sure that something about this trip is very, very wrong…

Maggie just wants to be home with her daughter, but she’s in a dangerous situation and she doesn’t know who put her there or why. She’ll have to fight with everything she has to survive…

Three women. Three stories. Only one way out. This captivating novel will keep readers guessing until the very end.
''',
      genre: ['Horror', 'Thriller', 'Mystery Thriller', 'Fiction', 'Adult'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1685351575i/122658643.jpg',
      isFavorite: false),
  Book(
      title: 'Lost Boy: The True Storyof Captain Hook',
      author: 'Christina Henry',
      publishedDate: DateTime(2017, 7, 4),
      rating: 4.22,
      description:
      '''From the national bestselling author of Alice comes a familiar story with a dark hook—a tale about Peter Pan and the friend who became his nemesis, a nemesis who may not be the blackhearted villain Peter says he is…

There is one version of my story that everyone knows. And then there is the truth. This is how it happened. How I went from being Peter Pan’s first—and favorite—lost boy to his greatest enemy.
 
Peter brought me to his island because there were no rules and no grownups to make us mind. He brought boys from the Other Place to join in the fun, but Peter's idea of fun is sharper than a pirate’s sword. Because it’s never been all fun and games on the island. Our neighbors are pirates and monsters. Our toys are knife and stick and rock—the kinds of playthings that bite.

Peter promised we would all be young and happy forever. Peter lies.
''',
      genre: ['Fantasy', 'Horror', 'Retellings', 'Fiction', 'Fairy Tales'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1505240721i/32828538.jpg',
      isFavorite: false),
  Book(
      title: 'The Girl in Red',
      author: 'Christina Henry',
      publishedDate: DateTime(2019, 6, 18),
      rating: 3.71,
      description:
      '''A postapocalyptic take on the perennial classic "Little Red Riding Hood", about a woman who isn't as defenseless as she seems.

It's not safe for anyone alone in the woods. There are predators that come out at night: critters and coyotes, snakes and wolves. But the woman in the red jacket has no choice. Not since the Crisis came, decimated the population, and sent those who survived fleeing into quarantine camps that serve as breeding grounds for death, destruction, and disease. She is just a woman trying not to get killed in a world that doesn't look anything like the one she grew up in, the one that was perfectly sane and normal and boring until three months ago.

There are worse threats in the woods than the things that stalk their prey at night. Sometimes, there are men. Men with dark desires, weak wills, and evil intents. Men in uniform with classified information, deadly secrets, and unforgiving orders. And sometimes, just sometimes, there's something worse than all of the horrible people and vicious beasts combined.

Red doesn't like to think of herself as a killer, but she isn't about to let herself get eaten up just because she is a woman alone in the woods....
''',
      genre: ['Horror', 'Fantasy', 'Retellings', 'Fiction', 'Dystopia'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1545249589i/42881101.jpg',
      isFavorite: false),
  Book(
      title: 'Red Queen',
      author: 'Christina Henry',
      publishedDate: DateTime(2016, 7, 12),
      rating: 3.83,
      description:
      '''The author of Alice takes readers back down the rabbit hole to a dark, twisted, and fascinating world based on the works of Lewis Carroll...
 
The land outside of the Old City was supposed to be green, lush, hopeful. A place where Alice could finally rest, no longer the plaything of the Rabbit, the pawn of Cheshire, or the prey of the Jabberwocky. But the verdant fields are nothing but ash—and hope is nowhere to be found.
 
Still, Alice and Hatcher are on a mission to find his daughter, a quest they will not forsake even as it takes them deep into the clutches of the mad White Queen and her goblin or into the realm of the twisted and cruel Black King.
 
The pieces are set and the game has already begun. Each move brings Alice closer to her destiny. But, to win, she will need to harness her newfound abilities and ally herself with someone even more powerful—the mysterious and vengeful Red Queen...
''',
      genre: ['Fantasy', 'Horror', 'Retellings', 'Fiction', 'Magic'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1453056797i/27246122.jpg',
      isFavorite: false),
  Book(
      title: 'Alice',
      author: 'Christina Henry',
      publishedDate: DateTime(2015, 8, 4),
      rating: 3.85,
      description:
      '''A mind-bending new novel inspired by the twisted and wondrous works of Lewis Carroll...

In a warren of crumbling buildings and desperate people called the Old City, there stands a hospital with cinderblock walls which echo the screams of the poor souls inside.

In the hospital, there is a woman. Her hair, once blond, hangs in tangles down her back. She doesn’t remember why she’s in such a terrible place. Just a tea party long ago, and long ears, and blood…

Then, one night, a fire at the hospital gives the woman a chance to escape, tumbling out of the hole that imprisoned her, leaving her free to uncover the truth about what happened to her all those years ago.

Only something else has escaped with her. Something dark. Something powerful.

And to find the truth, she will have to track this beast to the very heart of the Old City, where the rabbit waits for his Alice.
''',
      genre: ['Fantasy', 'Horror', 'Retellings', 'Fiction', 'Magic'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1531783537i/23398606.jpg',
      isFavorite: false),
  Book(
      title: 'Near The Bone',
      author: 'Christina Henry',
      publishedDate: DateTime(2021, 4, 13),
      rating: 3.73,
      description:
      '''A woman trapped on a mountain attempts to survive more than one kind of monster, in a dread-inducing horror novel from the national bestselling author Christina Henry.

Mattie can't remember a time before she and William lived alone on a mountain together. She must never make him upset. But when Mattie discovers the mutilated body of a fox in the woods, she realizes that they're not alone after all.

There's something in the woods that wasn't there before, something that makes strange cries in the night, something with sharp teeth and claws.

When three strangers appear on the mountaintop looking for the creature in the woods, Mattie knows their presence will anger William. Terrible things happen when William is angry.
''',
      genre: ['Fantasy', 'Horror', 'Mystery', 'Fiction', 'Mystery Thriller'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627151265i/54735151.jpg',
      isFavorite: false),
  Book(
      title: 'Girl Among Crows',
      author: 'Bredno Vayo',
      publishedDate: DateTime(2023, 11, 7),
      rating: 3.78,
      description: '''he Door Must Remain Open

When two boys vanish from her hometown, Daphne Gauge notices uncanny parallels to her brother’s disappearance 30 years earlier. Symbols of an ancient Norse god. Rumors of a promise to reward the town’s faithful with wealth and power, for a price. She warns her husband that another sacrifice is imminent, but just like last time, no one believes her.

That leaves Daphne with a desperate choice: investigate with limited resources, or give in to the FBI’s request for an interview. For years, they’ve wanted a member of the Gauge family to go on record about the tragedy back in 1988. If she agrees to a deposition now, Daphne must confess her family’s dark secrets. But she also might have one last chance to unmask the killer from back then . . . and now.

For readers who enjoy Stephen King, Gillian Flynn, Joshilyn Jackson, Riley Sager, Jennifer McMahon, and Simone St. James.
''',
      genre: ['Thriller', 'Horror', 'Mystery', 'Fiction', 'Mystery Thriller'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1676735083i/122757687.jpg',
      isFavorite: false),
  Book(
      title: 'We Are The Crisis',
      author: 'Cadwell Turnbull',
      publishedDate: DateTime(2023, 11, 7),
      rating: 4.09,
      description:
      '''In We Are the Crisis—the second book in the Convergence Saga from award-winning author Cadwell Turnbull—humans and monsters come into conflict in a magical and dangerous world as civil rights collide with preternatural forces.

In this highly anticipated sequel, set a few years after No Gods, No Monsters, humanity continues to grapple with the revelation that supernatural beings exist. A werewolf pack investigates the strange disappearances of former members and ends up unraveling a greater conspiracy, while back on St. Thomas, a hurricane approaches and a political debate over monster’s rights ignites tensions in the local community.

Meanwhile, New Era—a pro-monster activist group—works to build a network between monsters and humans, but their mission is threatened by hate crimes perpetrated by a human-supremacist group known as the Black Hand. And beneath it all two ancient orders escalate their conflict, revealing dangerous secrets about the gods and the very origins of magic in the universe.

Told backward and forward in time as events escalate and unravel, We Are the Crisis is a brilliant contemporary fantasy that takes readers on an immersive and thrilling journey.
''',
      genre: ['Fantasy', 'Horror', 'Paranormal', 'Fiction', 'Supernatural'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1687356471i/124053855.jpg',
      isFavorite: false),
  Book(
      title: 'Swarm',
      author: 'JenniferD. Lyle',
      publishedDate: DateTime(2023, 11, 7),
      rating: 3.81,
      description:
      '''Sixteen year-old Shur is one of the first to see the creatures. While staring out the window in history class, she spots one floating over the soccer field. It looks like a monarch butterfly—but it's huge. Within minutes, her classmates' phones are buzzing with emergency alerts. These things are everywhere, and though nobody's exactly sure why the alerts are telling them to take cover, Shur knows it can't be good. It's only when she's left school and headed home that she what the creatures do: they attack.

By the time Shur, her two brothers, and their two best friends make it back to her house, it's clear the five of them must survive whatever comes next on their own.

As the "butterflies"—new hybrid creatures thought to be created by climate change—multiply and swarm outside, anxiety-prone Shur focuses on what she can control: boarding up windows, stocking food, and preparing a shelter in the basement. They lose internet and power while vigilantes create terror outside. Meanwhile the creatures begin to fulfill their ultimate purpose: multiplying via parasitic load, and before long, the butterflies aren't the only thing trying to get in. To protect her family and survive the invasions, Shur must find the strength to protect their sanctuary at any cost.
''',
      genre: ['Dystopia', 'Horror', 'Thriller', 'Fiction', 'Mental Health'],
      imageAsset:
      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1682385988i/86033921.jpg',
      isFavorite: false),
];