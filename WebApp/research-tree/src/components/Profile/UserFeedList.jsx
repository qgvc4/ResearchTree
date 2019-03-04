import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchPosts} from '../../actions/FeedAction'
import UserFeedCard from './UserFeedCard';

class UserFeedList extends Component {
    componentWillMount() {
        this.props.fetchPosts(this.props.token);
    }

    render() {
        if( this.props.feeds !== undefined){

        this.props.feeds.sort(function(feed1,feed2){
            return new Date(feed2.modifyTime) - new Date(feed1.modifyTime);
        });

        let feeds = this.props.feeds.filter( feed => feed.peopleId === this.props.id);
        
        const feedItems = feeds.map(feed => (
            <div key={feed.id}>
                <UserFeedCard title={feed.title} description={feed.description} date={feed.modifyTime}/>
            </div>
        ));
        return (
        <div>
            <h1>My Posts</h1>
            {feedItems}
        </div>
        );
        }
        return (
            <div>
                <h1>My Posts</h1>
            </div>
            );
    }
}

UserFeedList.propTypes = {
    fetchPosts: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    token: state.user.user.token,
    id: state.user.user.id,
    feeds: state.feed.feeds,
    error: state.feed.error
  })

export default connect(mapStateToProps, { fetchPosts })(UserFeedList);