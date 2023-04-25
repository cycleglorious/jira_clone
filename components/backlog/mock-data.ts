import { type IssueType } from "./issue";

export const sprints = [
  { id: "P-SEB1" },
  { id: "P-SEB2" },
  { id: "P-SEB3" },
  // { id: null },
];
// const statuses: IssueType["status"][] = ["TODO", "IN_PROGRESS", "DONE"];
// const epics = ["EPIC-1", "EPIC-2", "EPIC-3"];
// const issueTypes: IssueType["type"][] = ["STORY", "TASK", "BUG"];

// export const generateIssues = (count: number) => {
//   const issues: IssueType[] = [];
//   const sprintCount = { "P-SEB1": 0, "P-SEB2": 0, "P-SEB3": 0, null: 0 };
//   for (let i = 0; i < count; i++) {
//     const sprint =
//       sprints[Math.floor(Math.random() * sprints.length)]?.id ?? "P-SEB1";
//     const epic = epics[Math.floor(Math.random() * epics.length)] ?? "EPIC-1";
//     const issue: IssueType = {
//       id: `issue-${i}`,
//       title: `Issue ${i}`,
//       description: "This is a description",
//       status: statuses[Math.floor(Math.random() * statuses.length)] ?? "TODO",
//       assignee:
//         i % 2 == 0
//           ? null
//           : {
//               id: "assignee_id",
//               name: "Sebastian Garcia",
//               email: "gar.seb@gmail.com",
//               avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
//             },
//       reporter:
//         i % 2 == 0
//           ? null
//           : {
//               id: "reporter_id",
//               name: "Sebastian Garcia",
//               email: "gar.seb@gmail.com",
//               avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
//             },
//       listPosition: sprintCount[sprint],
//       type:
//         issueTypes[Math.floor(Math.random() * issueTypes.length)] ?? "STORY",
//       sprint: sprint,
//       epic: epic,
//       comments: [],
//       logs: [],
//     };
//     issues.push(issue);
//     sprintCount[sprint]++;
//   }

//   console.log("issues => ", issues);
//   return issues;
// };

// export const issues: IssueType[] = generateIssues(40);
export const issues: IssueType[] = [
  {
    id: "issue-0",
    title: "Issue 0",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 0,
    type: "STORY",
    sprint: "P-SEB1",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-1",
    title: "Issue 1",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 0,
    type: "TASK",
    sprint: "P-SEB3",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-2",
    title: "Issue 2",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 1,
    type: "STORY",
    sprint: "P-SEB1",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-3",
    title: "Issue 3",
    description: "This is a description",
    status: "DONE",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 2,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-4",
    title: "Issue 4",
    description: "This is a description",
    status: "TODO",
    assignee: null,
    reporter: null,
    listPosition: 3,
    type: "TASK",
    sprint: "P-SEB1",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-5",
    title: "Issue 5",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 4,
    type: "TASK",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-6",
    title: "Issue 6",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 0,
    type: "BUG",
    sprint: "P-SEB2",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-7",
    title: "Issue 7",
    description: "This is a description",
    status: "DONE",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 5,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-8",
    title: "Issue 8",
    description: "This is a description",
    status: "DONE",
    assignee: null,
    reporter: null,
    listPosition: 6,
    type: "TASK",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-9",
    title: "Issue 9",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 7,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-10",
    title: "Issue 10",
    description: "This is a description",
    status: "TODO",
    assignee: null,
    reporter: null,
    listPosition: 8,
    type: "STORY",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-11",
    title: "Issue 11",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 1,
    type: "STORY",
    sprint: "P-SEB2",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-12",
    title: "Issue 12",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 9,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-13",
    title: "Issue 13",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 10,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-14",
    title: "Issue 14",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 2,
    type: "BUG",
    sprint: "P-SEB2",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-15",
    title: "Issue 15",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 1,
    type: "STORY",
    sprint: "P-SEB3",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-16",
    title: "Issue 16",
    description: "This is a description",
    status: "DONE",
    assignee: null,
    reporter: null,
    listPosition: 11,
    type: "TASK",
    sprint: "P-SEB1",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-17",
    title: "Issue 17",
    description: "This is a description",
    status: "DONE",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 12,
    type: "STORY",
    sprint: "P-SEB1",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-18",
    title: "Issue 18",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 3,
    type: "TASK",
    sprint: "P-SEB2",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-19",
    title: "Issue 19",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 13,
    type: "TASK",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-20",
    title: "Issue 20",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 4,
    type: "TASK",
    sprint: "P-SEB2",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-21",
    title: "Issue 21",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 2,
    type: "BUG",
    sprint: "P-SEB3",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-22",
    title: "Issue 22",
    description: "This is a description",
    status: "TODO",
    assignee: null,
    reporter: null,
    listPosition: 5,
    type: "STORY",
    sprint: "P-SEB2",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-23",
    title: "Issue 23",
    description: "This is a description",
    status: "TODO",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 0,
    type: "BUG",
    sprint: null,
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-24",
    title: "Issue 24",
    description: "This is a description",
    status: "DONE",
    assignee: null,
    reporter: null,
    listPosition: 14,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-25",
    title: "Issue 25",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 15,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-26",
    title: "Issue 26",
    description: "This is a description",
    status: "TODO",
    assignee: null,
    reporter: null,
    listPosition: 6,
    type: "STORY",
    sprint: "P-SEB2",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-27",
    title: "Issue 27",
    description: "This is a description",
    status: "DONE",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 1,
    type: "BUG",
    sprint: null,
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-28",
    title: "Issue 28",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 3,
    type: "BUG",
    sprint: "P-SEB3",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-29",
    title: "Issue 29",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 7,
    type: "TASK",
    sprint: "P-SEB2",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-30",
    title: "Issue 30",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 8,
    type: "STORY",
    sprint: "P-SEB2",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-31",
    title: "Issue 31",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 4,
    type: "STORY",
    sprint: "P-SEB3",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-32",
    title: "Issue 32",
    description: "This is a description",
    status: "DONE",
    assignee: null,
    reporter: null,
    listPosition: 16,
    type: "TASK",
    sprint: "P-SEB1",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-33",
    title: "Issue 33",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 17,
    type: "BUG",
    sprint: "P-SEB1",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-34",
    title: "Issue 34",
    description: "This is a description",
    status: "DONE",
    assignee: null,
    reporter: null,
    listPosition: 5,
    type: "STORY",
    sprint: "P-SEB3",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-35",
    title: "Issue 35",
    description: "This is a description",
    status: "TODO",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 9,
    type: "BUG",
    sprint: "P-SEB2",
    epic: "EPIC-1",
    comments: [],
    logs: [],
  },
  {
    id: "issue-36",
    title: "Issue 36",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: null,
    reporter: null,
    listPosition: 2,
    type: "STORY",
    sprint: null,
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-37",
    title: "Issue 37",
    description: "This is a description",
    status: "IN_PROGRESS",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 10,
    type: "STORY",
    sprint: "P-SEB2",
    epic: "EPIC-2",
    comments: [],
    logs: [],
  },
  {
    id: "issue-38",
    title: "Issue 38",
    description: "This is a description",
    status: "TODO",
    assignee: null,
    reporter: null,
    listPosition: 6,
    type: "TASK",
    sprint: "P-SEB3",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
  {
    id: "issue-39",
    title: "Issue 39",
    description: "This is a description",
    status: "TODO",
    assignee: {
      id: "assignee_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    reporter: {
      id: "reporter_id",
      name: "Sebastian Garcia",
      email: "gar.seb@gmail.com",
      avatar: "https://avatars.githubusercontent.com/u/42552874?v=4",
    },
    listPosition: 18,
    type: "TASK",
    sprint: "P-SEB1",
    epic: "EPIC-3",
    comments: [],
    logs: [],
  },
];
