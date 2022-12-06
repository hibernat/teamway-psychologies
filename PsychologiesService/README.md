# PsychologiesService

Provides access to psychologies quiz API through *PsychologiesServiceProtocol*:
``` swift
func getTraitQuiz() async throws -> TraitQuiz
func submitTraitQuizAnswers(traitTestId: String, answerIds: [String]) async throws -> TraitQuizEvaluation
```

Implementation of *PsychologiesService* is **mocked**!
