import React, { Component } from 'react'
import { Button } from 'antd';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {newPost, fetchPosts} from '../../actions/FeedAction'

class NewFeedForm extends Component {
    onSubmit = () => {
        console.log("new post button clicked")
        const webPostTest = {
            "Title": "web post test",
            "PeopleId": `${this.props.user.id}`,
            "Description": "web post has been created"
        }
        this.props.newPost(this.props.user.token, webPostTest)
        this.props.fetchPosts(this.props.user.token)
    }
    render() {
        return (
        <div>
            <Button type="primary" onClick={this.onSubmit}>Primary</Button>
        </div>
        )
    }
}


NewFeedForm.propTypes = {
    newPost: PropTypes.func.isRequired,
    fetchPosts: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    user: state.user.user,
    feeds: state.feed.feeds,
    error: state.feed.error
  })

export default connect(mapStateToProps, { fetchPosts, newPost })(NewFeedForm);
