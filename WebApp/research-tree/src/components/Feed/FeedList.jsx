import React, { Component } from 'react'
import _ from 'lodash';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchPosts} from '../../actions/FeedAction';
import {fetchUsers} from '../../actions/PeopleAction';
import FeedCard from './FeedCard';

class FeedList extends Component {
    componentWillMount() {
        this.props.fetchPosts(this.props.token);
        this.props.fetchUsers(this.props.token);
    }

    render() {
        this.props.feeds.sort(function(feed1,feed2){
            return new Date(feed2.modifyTime) - new Date(feed1.modifyTime);
        });
        
        const feedItems = this.props.feeds.map(feed => (
            <div key={feed.id} style={{margin: '2%'}}>
                <FeedCard feed={ feed } author = { this.findAuthor(feed.peopleId) }/>
            </div>
        ));
        return (
        <div>
            <h1 style={{ color: '#74997a', textAlign: 'center' }}>Feeds</h1>
            {feedItems}
        </div>
        )
    }

    findAuthor = (peopleId) => {
        console.log(this.props.users)
        var i = _.findIndex(this.props.users, ['id', peopleId]);
        if (i === -1) {
            return this.props.me
        }
        return this.props.users[i];
    }
}

FeedList.propTypes = {
    fetchPosts: PropTypes.func.isRequired,
    fetchUsers: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    me: state.user.user,
    token: state.user.user.token,
    feeds: state.feed.feeds,
    users: state.people.users,
    error: state.feed.error
  })

export default connect(mapStateToProps, { fetchPosts, fetchUsers })(FeedList);