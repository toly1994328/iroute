class Node {
  final String value;
  final List<Node> children;

  Node({required this.value, this.children = const []});

  @override
  String toString() {
    return 'Node{value: $value}';
  }
}

Node root = Node(value: 'root', children: [
  Node(
    value: '1',
    children: [
      Node(value: '1-1'),
      Node(value: '1-2'),
      Node(value: '1-3'),
    ],
  ),
  Node(
    value: '2',
    children: [
      Node(value: '2-1'),
      Node(value: '2-2'),
      Node(value: '2-3',children: [
        Node(value: '2-3-1',),
      ]),
    ],
  ),
  Node(
    value: '3',
    children: [
      Node(value: '3-1'),
      Node(value: '3-2', children: [
        Node(value: '3-2-1',),
      ]),
    ],
  ),
]);

Node root2 = Node(value: '/', children: [
  Node(
    value: '/1',
    children: [
      Node(value: '/1/1'),
      Node(value: '/1/2'),
      Node(value: '/1/3'),
    ],
  ),
  Node(
    value: '/2',
    children: [
      Node(value: '/2/1'),
      Node(value: '/2/2'),
      Node(value: '/2/3',children: [
        Node(value: '/2/3/1',),
      ]),
    ],
  ),
  Node(
    value: '/3',
    children: [
      Node(value: '/3/1'),
      Node(value: '/3/2', children: [
        Node(value: '/3/2/1',),
      ]),
    ],
  ),
]);