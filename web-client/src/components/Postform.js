import React, { Component } from 'react'

class PostForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
        title: "",
        description: ""
    };

    this.onChange = this.onChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  onChange(e) {
      this.setState({[e.target.name]: e.target.value});
  }

  onSubmit(e) {
      e.preventDefault();

      const post = {
          title: this.state.title,
          description: this.state.description,
          PeopleId: "tester"
      }

      fetch('https://researchtreeapis.azurewebsites.net/api/feeds', {
          method: "POST",
          headers: {
              "content-type": "application/json"
          },
          body: JSON.stringify(post)
      })
      .then(res => res.json())
      .then(data => console.log(data))
  }
  
  render() {
    return (
      <div>
        <h1>Add Post</h1>
        <form onSubmit={ this.onSubmit }>
            <div>
                <label>Title: </label><br />
                <input type="text" name="title" onChange={ this.onChange } value={ this.state.title }/>
            </div>
            <div>
                <label>Description: </label><br />
                <textarea name="description" onChange={ this.onChange } value={ this.state.description }/>
            </div>
            <button type="submit">Submit</button>
        </form>
      </div>
    )
  }
}

export default PostForm;