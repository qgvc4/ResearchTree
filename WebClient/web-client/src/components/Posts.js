import React, { Component } from 'react'

class Posts extends Component {
    componentWillMount() {
        fetch('http://localhost:51805/api/feeds')
            .then(res => res.json())
            .then(data => console.log(data));
    }
  render() {
    return (
      <div>
        <h1>Posts</h1>
      </div>
    )
  }
}

export default Posts;
