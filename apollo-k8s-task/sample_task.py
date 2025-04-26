from inspect_ai import Task, task
from inspect_ai.dataset import Sample
from inspect_ai.scorer import Score, Target, mean, scorer
from inspect_ai.solver import TaskState
from inspect_ai.util import sandbox

SOLUTION = "42"


@scorer(metrics=[mean()])
def read_file_scorer():
    async def score(state: TaskState, target: Target):
        solution = await sandbox().read_file("solution.txt")
        score = solution == SOLUTION
        return Score(value=score, answer=solution)

    return score


@task
def read_file() -> Task:
    return Task(
        dataset=[Sample(input="", files={"solution.txt": SOLUTION})],
        solver=[],
        sandbox="local",  # TODO: Run this in the k8s sandbox
        scorer=read_file_scorer(),
    )
